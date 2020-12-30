+++
title = "Spin Squeezing"
author = ["Trent Fridey"]
date = 2020-10-10
tags = ["quantum", "statistics", "physics"]
draft = true
+++

## The Setup {#the-setup}

Let's consider a quantum system of \\(N\\) spin-\\(1/2\\) particles.
These spins are prepared in a _coherent_ state:

\\[
  \left| \theta, \phi \right\rangle = \frac{1}{\sqrt{N}}\bigotimes\_{i=1}^N  \left[
    \cos{\left(\frac{\theta}{2}\right)}|0\rangle +
    e^{i\phi}\sin\left({\frac{\theta}{2}}\right)|1\rangle
  \right]
  \\]


### Bloch Sphere {#bloch-sphere}

If we calculate the expected value of the total spin operator of this state:

\\[
  \vec{S} = \sum\_{i=1}^N \vec{S}\_i
  \qquad
  \vec{S}\_i = \frac{1}{2}\left(\sigma^x\_i \hat{x} + \sigma^y\_i \hat{y} + \sigma^z\_i \hat{z}\right)
  \\]

we get a nice geometric result:

\\[
  \left\langle \theta, \phi \right| \vec{S} \left| \theta, \phi \right\rangle =
  \frac{N}{2}\sin{\theta}\cos{\phi}\hat{x} +
  \frac{N}{2}\sin{\theta}\sin{\phi}\hat{y} +
  \frac{N}{2}\cos{\theta}\hat{z}
  \\]

We can assign \\(\theta\\) as the azimuthal angle and \\(\phi\\) as the polar angle.
Then we have the picture of a vector in 3D space, constrained to a sphere of radius \\(\frac{N}{2}\\).
Proceeding in this way, we call the direction this vector points the _mean spin direction_ or MSD.

We can form a vector \\(\hat{n}\_\perp\\) which is perpendicular to the MSD such that \\(\langle \vec{S} \rangle \cdot \hat{n}\_\perp = 0\\)  .
If the tip of the \\(\langle \vec{S} \rangle\\) vector can be represented by a point \\((\theta\_0, \phi\_0)\\) on a sphere, then the \\(\hat{n}\_\perp\\) vector can be thought of as being tangent to the sphere at this point.

Because the vector \\(\langle\vec{S}\rangle\\) is an expectation value, we can calculate the variance of it: \\(\Delta \vec{S}^2 = \left\langle \vec{S}\cdot\vec{S} \right\rangle - \left\langle \vec{S} \right\rangle^2\\).
We can also decompose the variance into the variance along the MSD (denoted by \\(\Delta \vec{S}\_{\parallel}^2\\)) and perpendicular to the MSD (denoted by \\(\Delta \vec{S}\_{\perp}^2\\)).

\\[
\Delta \vec{S}^2 = \Delta \vec{S}\_{\parallel}^2 + \Delta \vec{S}\_{\perp}^2
\\]

From our definition of \\(\hat{n}\_\perp\\), the second term will be the variance along \\(\hat{n}\_\perp\\).


### Husimi Q-function {#husimi-q-function}

If we calculate \\(\Delta \vec{S}\_{\perp}\\), we can relate it to another important measure of the coherent state: the _Husimi Q-function_, which is defined for a general spin state \\(|\psi\rangle\\) as:

\\[
  Q(\theta, \phi) = |\langle \theta, \phi | \psi \rangle |^2
  \\]

```python
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm, colors
import numpy as np
from scipy.special import sph_harm

phi = np.linspace(0, 2*np.pi, 100)
theta = np.linspace(0, np.pi, 100)
phi, theta = np.meshgrid(phi, theta)

x = np.sin(theta) * np.cos(phi)
y = np.sin(theta) * np.sin(phi)
z = np.cos(theta)

theta0, phi0 = np.pi/2, 0

def q_func(theta0, phi0):
    return 1


return name
```


## Introducing Squeezing {#introducing-squeezing}


### <span class="org-todo todo TODO">TODO</span> Use plot of Husimi function to motivate squeezing {#use-plot-of-husimi-function-to-motivate-squeezing}

We can get a better measurement by reducing the variance of the measurement.
If variance = width of Q function, then decreasing width of Q-function should increase measurement precision.


#### <span class="org-todo todo TODO">TODO</span> Catch: Heisenberg Uncertainty relation {#catch-heisenberg-uncertainty-relation}

There is a tradeoff in this procedure, due to the way quantum mechanics works.
It is quantified by the _Heisenberg uncertainty relation_:

\\[
    \Delta S\_i \Delta S\_j \geq \epsilon\_{ijk}S\_k
    \\]


### Definition of Squeezing Operator {#definition-of-squeezing-operator}


#### <span class="org-todo todo TODO">TODO</span> Motivate definition with Mean field description {#motivate-definition-with-mean-field-description}

How to induce a change in the Q-function?
We only have the Pauli spin operators to work with, so we must construct a squeezing operator out of these.
Any transformation must come from either a sum of single body operators or a sum of multi-body operators.
The sum of single body operators induce rotations.
Anything more than 2-body interactions may be complex.
The simplest operator is a sum of 2-body operators..

The spin squeezing operator is defined as:

\\[
   U(t) = \exp\left(-\frac{i}{2}t \sum\_{i \neq j}^N \sigma^z\_i\sigma^z\_j\right)
   \\]

This is called the _one-axis twisting_ operator in the literature.
With this definition, we apply it to a coherent state \\(\left|\theta=0, \phi=\frac{\pi}{2} \right\rangle = |+x\rangle\\) to  obtain the state:

\\[
   \left|\psi(t)\right\rangle = U(t)|+x\rangle
   \\]


#### <span class="org-todo todo TODO">TODO</span> connect with Q function {#connect-with-q-function}


### Quantifying Squeezing {#quantifying-squeezing}

We can quantify the degree that the state has been squeezed by comparing it to the initial state.
We expect that a squeezed state should have a smaller variance in one direction than the initial state.


#### <span class="org-todo todo TODO">TODO</span> introduce minimum variance spin operator {#introduce-minimum-variance-spin-operator}

\\[
  \Delta S\_{\text{min}}^2 = \min\_{\hat{n}} \Delta \left(\vec{S}\cdot\hat{n}\right)^2
  \\]


#### <span class="org-todo todo TODO">TODO</span> define squeezing parameter {#define-squeezing-parameter}


## Numerical simulations {#numerical-simulations}


### Finding the Optimal Angle {#finding-the-optimal-angle}


#### <span class="org-todo todo TODO">TODO</span> Use Python's autograd Library to Compute {#use-python-s-autograd-library-to-compute}

Implement squeezing parameter as a function of only numpy functions available to [autograd](https://github.com/HIPS/autograd).
