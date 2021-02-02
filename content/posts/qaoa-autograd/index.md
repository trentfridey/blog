+++
title = "Using autograd in Python for Quantum Computing"
author = ["Trent Fridey"]
date = 2021-01-31
tags = ["quantum-computing", "python", "autodiff"]
draft = false
+++

I recently participated in a challenge in quantum computing posed by the [Quantum Open Source Foundation](https://qosf.org).
In this post, I recap the problem description and my solution to the challenge.
The challenge involves exploring the ability of a certain class of quantum circuits in preparing a desired four-qubit quantum state.
In this challenge, the problem is to optimize a quantum circuit composed of layers of parameterized gates.
To solve this, we implement the circuit in Python and optimize the parameters using the [autograd](https://github.com/HIPS/autograd) library.


## Goal {#goal}

The cost function we are going to minimize is:

\\[
  \varepsilon = \min\_{\theta}\left||\psi(\theta)\rangle - |\phi\rangle \right|
  \\]

where \\(|\psi(\theta)\rangle\\) is the state of the system after going through the circuit and the initial state is \\(|\psi\rangle = |0000\rangle\\).

We choose the state \\(|\phi\rangle\\) to be the 4-qubit [GHZ](https://en.wikipedia.org/wiki/Greenberger%E2%80%93Horne%E2%80%93Zeilinger%5Fstate) state:

\\[
    \left|\phi\right\rangle = \frac{1}{\sqrt{2}} \left(\left|1111\right\rangle + \left|0000\right\rangle\right)
  \\]


## Circuit Description {#circuit-description}

The circuit is composed of a variable number of layers of blocks. There are only two types of blocks &mdash; odd and even &mdash; and they have parameters we can tweak to prepare the given state.
  The blocks are arranged [QAOA](https://arxiv.org/abs/1709.03489)-style, which means each layer has the even block following the odd block.

{{< figure src="/ox-hugo/circuit_drawing.svg" >}}

The even blocks are composed of the following gates:

{{< figure src="/ox-hugo/even_block.svg" width="80%" >}}

In mathematical notation:

\\[
U\_i^{\text{even}}(\theta\_{i,n}) = \left(\prod\_{\langle j,k \rangle}CZ(j,k) \bigotimes\_{n=1}^4 R\_{z}(\theta\_{i,n}) \right)
\\]

The odd blocks are composed of the rotation-X gates:

{{< figure src="/ox-hugo/odd_block.svg" width="20%" >}}

In mathematical notation:

\\[
U\_i^{\text{odd}}(\theta\_{i,n}) = \left( \bigotimes\_{n=1}^{4} R\_{x}(\theta\_{i,n}) \right)
\\]

The operator for the \\(\ell^{\text{th}}\\) layer is:

\\[
U\_{\ell} = U^{\text{even}}\_{2\ell} U^{\text{odd}}\_{\ell}
\\]


## Implementation {#implementation}

In the Python code below, we calculate \\(\varepsilon\\) by constructing the unitary operator for the circuit with a specified number of layers (`n_layers`), and then we use the `autograd` library to find the minimum.

But first we have define our gates:

```python
import autograd.numpy as np
from functools import reduce

    def Rx(theta):
      return np.array([[np.cos(0.5*theta),-1j*np.sin(0.5*theta)],
                       [-1j*np.sin(0.5*theta),np.cos(0.5*theta)]])

    def Rz(theta):
      return np.array([[np.cos(-0.5*theta) + 1j*np.sin(-0.5*theta),0],
                       [0,     np.cos(0.5*theta) + 1j*np.sin(theta) ]])

    def CZ(i,j):
        ops0 = [np.eye(2) for i in range(4)]
        ops1 = [np.eye(2) for i in range(4)]
        ops0[i] = p0
        ops1[i] = p1
        ops1[j] = sz
        cz0 = reduce(lambda res, op: np.kron(res, op), ops0)
        cz1 = reduce(lambda res, op: np.kron(res, op), ops1)
        return cz0 + cz1
```

From these basic gates we can create the blocks:

```python
 def odd(thetas):
   rot = Rx(thetas[0])
   rots = [Rx(theta) for theta in thetas[1:]]
   for r in rots:
     rot = np.kron(rot, r)
   return rot

def even(thetas):
  rot = Rx(thetas[0])
  rots = [Rz(theta) for theta in thetas[1:]]
  for r in rots:
    rot = np.kron(rot, r)
  CZs = np.eye(16)
  for i in range(3):
    for j in range(i+1, 4):
      CZs = CZ(i,j) @ CZs
  return CZs @ rot
```

And from the blocks, we can create the layers:

```python
def layer(thetas):
  return even(thetas[4:8]) @ odd(thetas[0:4])
```

and define the circuit:

```python
def circuit(thetas):
  circuit = np.eye(16)
  for l in range(n_layers):
    circuit = layer(thetas[8*l:8*(l+1)]) @ circuit
  return circuit
```

To setup the minimization, we need to specify an objective function (i.e. \\(\varepsilon\\)) to auto-differentiate.

The following code block loads the `autograd` library, encodes our cost function in the `objective` function and computes the AD gradient.

```python
from autograd import grad

start_state = np.array([1] + [0 for i in range(1,16)])
target = 0.5*np.sqrt(2) *(np.array([1] + [0 for i in range(1,15)] + [1]))

def objective(thetas,iter):
  circ = circuit(thetas)
  normalization = np.sum(np.abs(np.dot(circ, start_state)))
  normalized_final_state = np.abs(np.dot(circ, start_state)/normalization
  return np.sum(normalized_final_state - target)

grad_obj = grad(objective)
```

To implement the minimization, we need to specify a few things:

-   a minimizer (here we choose [`adam`](https://en.wikipedia.org/wiki/Stochastic%5Fgradient%5Fdescent#Adam))
-   the initial values for the parameters \\(\theta\_{i,n}\\):
    I use samples from the normal distribution \\(N(0,\pi^2)\\)
-   the step size and the number of iterations:
    I chose a step size of 0.1 and at least 400 iterations. The trade-off here is speed vs. accuracy.

We call the minimizer by passing these configuration options to `adam`. It will return us the optimized values for \\(\theta\_{i,n}\\), which we then use to compute \\(\varepsilon\\) by passing them to the `objective` function.

```python
# Optimization
init_thetas = np.random.normal(0, np.pi, 8*n_layers)
step_size = 0.1
num_iters = 400 + 20*n_layers

optimized_thetas = adam(grad_obj, init_thetas, step_size=step_size, num_iters=num_iters, callback=handle_step)

epsilon = objective(optimized_thetas,0)
```

For debugging purposes, we also pass a `callback` to our minimization routine -- here's the definition of `handle_step`, which prints the objective every 20 steps:

```python
def handle_step(params, iter, grad):
  if iter % 20 == 0:
    print("Cost after {} steps is {}".format(iter, objective(params, iter)))
```

After running this with over a few layers and iterations, we can check the optimal value of our cost function \\(\varepsilon\\) via a plot.
In the figure below, we have plotted the ranges of values of \\(\varepsilon\\) that the `adam` optimizer returns, for one, two, three, and four layers respectively.
Since we are using a stochastic algorithm, the results are not the same every time, so we use a boxplot to see the distribution of results for each layer.

{{< figure src="/ox-hugo/results.png" >}}

Sanity check: _does the range of values for \\(\varepsilon\\) make sense?_

Well, our cost function involves the magnitude of the difference of two normalized vectors.
The maximum difference of two normalized vectors is 2, when they are pointing in exactly opposite directions.
The minimum difference would be 0, when they are perfectly aligned.
Since the plot shows results between 0.4 and 1.6, we can conclude that the results are not totally out-of-the-question.

From this plot, we can see that, for a small number of layers, more layers yields a better result.
This means that we can take the results of the optimization for `n_layers = 4`, and plug them into our quantum circuit, and approximate the GHZ state!
