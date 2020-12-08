+++
title = "Fisher Information and Physics"
author = ["Trent Fridey"]
date = 2020-10-06
draft = false
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


### In Classical Mechanics {#in-classical-mechanics}


### In Quantum Mechanics {#in-quantum-mechanics}
