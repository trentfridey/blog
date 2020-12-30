+++
title = "Fisher Information and Physics"
author = ["Trent Fridey"]
date = 2020-10-06
draft = true
+++

## Fisher's Inequality {#fisher-s-inequality}

Our starting point is in classical statistics, looking at population statistics.
Forming an estimate of parameters of the population via small samples allows us to get a grip on important characteristics of a population without exhaustive sample sizes.
The trade-off is in how close the estimators can get to the actual parameter.

From classical statistics, this is due to the random nature of samples.
If a sample is modeled a random variable with an underlying distribution, then any estimator made from it will inherit the random nature.
This means that the estimator will, in general, have a non-zero expected value and variance.

_Fisher's inequality_ puts a lower bound on the variance of the estimator.


### Expected Value of an Estimator {#expected-value-of-an-estimator}

The **bias** of an estimator \\(\hat{\theta}\\) of a population parameter \\(\theta\\) is defined as:

\\[
   b(\hat{\theta}) = E[\hat{\theta}] - \theta
   \\]


### Variance of an Estimator {#variance-of-an-estimator}

\\[
  V[\hat{\theta}] \geq
  \left(1 + \frac{\partial b}{\partial \theta}\right) /
  \left(\frac{\partial P}{\partial \theta}\right)^2
 \\]


## Fisher Information {#fisher-information}

The _Fisher information_ is defined as:

\\[
  I(\theta) = -E\left[\frac{\partial^2 \log P}{\partial \theta}\right]
  \\]


### In Classical Mechanics {#in-classical-mechanics}


### In Quantum Mechanics {#in-quantum-mechanics}

\\[
   \frac{-\hbar^2}{2m}\nabla^2 \psi + V \psi = i\hbar\frac{\partial \psi}{\partial t}
   \\]

Using \\(\psi(x,t) =\sqrt{P(x,t)}\exp(iS(x,t)/\hbar)\\), we get

\\[
   \frac{-\hbar^2}{2m}\left(\frac{(\nabla P)^2}{4P^2} - \frac{\nabla^2 P}{2P}\right) + \frac{(\nabla S)^2}{2m} + V =
   -\frac{\partial S}{\partial t}
 \\]

\\[
   \frac{1}{m}\nabla\cdot(P\nabla S) + \frac{\partial P}{\partial t} = 0
   \\]

When we take the expectation value of the real part, we end up with:

\\[
 \left\langle  \frac{(\nabla S)^2}{2m} + V + \frac{\partial S}{\partial t}
\right\rangle = \frac{\hbar^2}{8m}I  \label{eq:1}
  \\]

 Which to me seems very interesting.
 First of all, the left hand side is (the expectation value of) the [Hamilton Jacobi Equation](https://en.wikipedia.org/wiki/Hamilton%E2%80%93Jacobi%5Fequation).
 While there is an entire theory surrounding the HJ equation, for present purposes we just need to know that it, in some sense, describes the dynamics of a physical system.
And while the function \\(S\\) is at the heart of HJ theory, the HJ equation is written in terms of the system's energy.

Now, on the right hand side, we have the quantum Fisher information (QFI), \\(I\\).
Since both sides of the equation must have the same units, the quantity \\(\frac{\hbar^2}{8m}I\\) must have units of energy.
Therefore, the QFI contributes to the system's energy, or at least it should be taken into account when computing the dynamics of the quantum system.
