+++
title = "Equivalent Time Series"
author = ["Trent Fridey"]
date = 2020-12-08
tags = ["math", "statistics", "time-series"]
draft = false
+++

Let \\(R\\) be a random Rayleigh-distributed variable.
Let \\(\phi\\) be a random uniformly-distributed variable.

The time series defined by:

\\[
Y\_t = R\cos{(2\pi(ft + \phi))}
\\]

with \\(t\in\mathbb{Z}\\), is equivalent to the time series

\\[
Y\_t' = U + V
\\]

if \\(U\\) and \\(V\\) are independently distributed standard normal variables:

\\[
U, V \sim N(0,1)
\\]

Equivalence in this context means that \\(Y\_t\\) and \\(Y'\_t\\) have the same PMFs.


## Proof {#proof}


### Distribution of Cosine {#distribution-of-cosine}

The PDF of \\(\cos(2\pi(ft + \phi))\\) can be derived from the PDF of \\(\phi\\) using the rule for functions of a random variable:
For a random variable \\(X\\) with PDF \\(f\\), and an invertible function \\(Y(X)\\), the PDF \\(g\\) of \\(Y\\) is given by:

\\[
  g(y) = f(x(y))\left|\frac{d x}{d y}\right|
  \\]

In the case that \\(Y = \cos(2\pi(ft + \phi))\\) and \\(f\\) is the uniform distribution, we get:

\\[
  g(y) = \frac{1}{\sqrt{1-y^2}}
\\]

With this, we can calculate the PMF of \\(Y\\) in terms of \\(\phi\\):

\\[
\text{Pr}(g(Y)) = \int g(y) dy
\\]
\\[
= \int\frac{1}{\sqrt{1-y^2}} dy
\\]

\\[
=\int\frac{\sin(2\pi(ft+\phi))}{2\pi\sqrt{1-\cos^2(2\pi(ft + \phi))}}d\phi
\\]

\\[
=\int \frac{d\phi}{2\pi}
\\]

In other words

\\[
\phi \sim U(0,1) \implies \cos(2\pi(ft + \phi)) \sim U(0,2\pi)
\\]


### Equivalence of Series {#equivalence-of-series}

The PMF of \\(Y\_t\\) can be expressed as a product, since \\(R\\) and \\(\phi\\) are independent:

\\[
\text{Pr}(R\cos(2\pi(ft + \phi))) = \text{Pr}( R)\text{Pr}(\cos(2\pi(ft + \phi)))
\\]

\\[
= \int r e^{-r^2/2} dr \int \frac{1}{2\pi} d\phi
\\]

\\[
= \frac{1}{2\pi}\iint r e^{-r^2/2} dr d\phi
\\]

Change our variables of integration:

\\[
u = r\cos(\phi), \qquad v = r\sin(\phi)
\\]

Then we can write:
\\[
\text{Pr}(R\cos(2\pi(ft + \phi))) = \frac{1}{2\pi}\iint e^{-(u^2+v^2)/2} du dv
\\]

Which is the PMF of the time series defined by \\(Y\_t' = U + V\\). \\(\square\\)
