+++
title = "Conformal Maps"
author = ["Trent Fridey"]
date = 2020-10-18
tags = ["complex-analysis", "math"]
draft = true
+++

## <span class="org-todo todo TODO">TODO</span> Rework this entire post -- the schwarz christoffel approach is wrong {#rework-this-entire-post-the-schwarz-christoffel-approach-is-wrong}


### <span class="org-todo todo TODO">TODO</span> Rework the Introduction {#rework-the-introduction}


### <span class="org-todo todo TODO">TODO</span> Rework the Transforming to the Right Geometry section {#rework-the-transforming-to-the-right-geometry-section}


## Introduction {#introduction}

The Schwarz-Christoffel transformation:

\\[
w = \int^x (\xi - x\_1)^{(\phi/\pi)-1}(\xi - x\_2)^{(\phi\_2/\pi)-1}\cdots (\xi - x\_n)^{(\phi\_n/\pi)-1}\mathrm{d}\xi
\\]

is an unprobable integral transform that maps the points \\(x\_n\\) on the real number line to the vertices of a polygon in the complex plane, with interior angles \\(\phi\_n\\).
It belongs to a larger class of transforms under the name of [conformal transformations](https://en.wikipedia.org/wiki/Conformal%5Fmap).
What is utterly fascinating is that such a seemingly esoteric integral has applications in _engineering_.


### Cauchy-Riemann Equation implies Laplace's Equation {#cauchy-riemann-equation-implies-laplace-s-equation}

In complex analysis, one is first interested in functions that are **analytic** -- e.g. a function \\(f\\) of the complex variable \\(z = x + iy\\) must satisfy the _Cauchy Riemann Equation_:

\\[
   \frac{\partial f}{\partial x} + i\frac{\partial f}{\partial y} = 0
   \\]

The upshot of this is that the real and imaginary parts of \\(f(z) = u(x,y) + iv(x,y)\\) both satisfy Laplace's equation:

\\[
   \frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} = 0
   \qquad
   \frac{\partial^2 v}{\partial x^2} + \frac{\partial^2 v}{\partial y^2} = 0
   \\]

This is useful for applications, since Laplace's equation shows up in many theories of physics.
Importantly, it holds under conformal maps of the variable \\(z\\).


### <span class="org-todo todo TODO">TODO</span> Conformal Maps {#conformal-maps}

Conformal maps are functions of complex variables that preserves local angles, while allowing transformations of lengths.
In general, they transform the ortholinear 2D complex plane to curved 2D geometry (or vice versa).

TODO: insert image here


## Applications {#applications}

We can apply this background to solve Laplace's equation in 2D for problems where the boundary conditions are "difficult" to solve.
The procedure is:

1.  Identify the 2D domain with the complex plane
2.  Identify a conformal map that takes the "difficult" boundary conditions to an easier geometry (such as square or unit disc)
3.  Find a real function of two variables that satisfies Laplace's equation and the boundary conditions in this easier geometry
4.  Compute the inverse conformal map to get the solution from the "easier" geometry to the "difficult" geometry.

    Let's look at using it to compute the electric potential of a specific geometry in 2D


### The Electric Potential of a Semi-Infinite Plane {#the-electric-potential-of-a-semi-infinite-plane}

The problem we are interested in solving is this: what is the electric potential \\(\varphi\\) on the upper half-plane \\(\\{(x,y)\space  |  y > 0\\}\\), where the boundary conditions are:

\\[
\varphi(x,y) = \begin{cases}
V & -\infty < x < 0, y = 0 \\\ 0 & 0 \leq x < \infty, y = 0
\end{cases}
\\]

Here's a picture:

{{< figure src="/ox-hugo/domain.svg" caption="Figure 1: The problem setup with boundary conditions" >}}

To solve this, we first identify the domain of the upper-half-plane of \\(\mathbb{R}^2\\) with the upper-half-plane of the complex plane \\(\mathbb{C}\\).
This means we will consider \\(\varphi(x,y)\\) as the real part of a complex function \\(F(z)\\).
We can do this thanks to the Cauchy-Riemann relations.

Next we will need to identify a conformal map that will map the domain to a familiar geometry for solving Laplace's equation in 2D -- the square.


#### Transforming to the Right Geometry {#transforming-to-the-right-geometry}

We want a transformation that maps the upper half of the complex plane to the interior of a square.
We choose the corners of this square to be the image of the points \\(z = -1, 0, 1\\).
In effect, we are looking for a function \\(w(z) = r(x,y) + is(x,y)\\).

In stages:

1.  Initial state with vertices identified

    {{< figure src="/ox-hugo/w-plane-1.svg" >}}

2.  Rotating the tangent vector at (-1,0)

    {{< figure src="/ox-hugo/w-plane-2.svg" >}}

3.  Rotating the tangent vector at (0,0)

    {{< figure src="/ox-hugo/w-plane-3.svg" >}}

4.  Final rotation. The domain is the gray area inside

    {{< figure src="/ox-hugo/w-plane.svg" >}}

This procedure is effected by the Schwarz-Christoffel transformation with:

\\[
 \phi\_1 = \phi\_2 = \phi\_3 = \pi(1-1/2) = -\pi/2 \\\x\_1 = 0, x\_2 = -1, x\_3 = 1
 \\]

This means the integrand will be:
\\[
 (\xi)^{-1/2}(\xi+1)^{-1/2}(\xi-1)^{-1/2} = \frac{1}{\sqrt{\xi^3-\xi}}
\\]

So our map taking us from the upper half-plane to a square is:

\\(w(z) : z \to w\\)

\\[
w = \int^z \frac{1}{\sqrt{\xi^3 - \xi}}\mathrm{d}\xi \tag{1}
\\]


#### Problem Statement and Solution {#problem-statement-and-solution}

Now we have mapped the upper half complex plane to a square, we have a familiar geometry for solving Laplace's equation.
But since the mapping is conformal, it doesn't guarantee that the length of the sides of the square were preserved, so let us call the side length \\(a\\).

Our problem to solve now is:

Find \\(\phi(r,s)\\) on the domain \\(\Omega = \\{ (r,s) \, | \, 0 < r < a, 0 < s < a \\}\\)

\\[
    \nabla^2 \phi = 0 \qquad \text{on} \, \Omega
    \\]

With the boundary conditions:

\\[
    \phi = \begin{cases}
    V & (a, s), (r,0)  \\\0 & (0, s), (r,a)
    \end{cases}
    \quad  \text{for} \, (r,s) \in  \partial \Omega
    \\]

Proceeding in the usual way, this can be solved via separation of variables:

\\[
\nabla^2\phi(r,s) = \frac{R''( r)}{R( r)} + \frac{S''(s)}{S(s)}
\\]

Since there is a degree of symmetry in the boundary conditions, the general solution will be:

\\[
\phi(r,s) = \sum\_{n}c\_n
\left[
\sin\left(\frac{n\pi r}{a}\right)\sinh\left(\frac{n\pi(s-a)}{a}\right) +
\sinh\left(\frac{n\pi r}{a}\right)\sin\left(\frac{n\pi(s-a)}{a}\right)
\right]
\\]

By following the usual procedure for determining the Fourier coefficients, we will find that the \\(c\_n\\) are proportional to \\((-1)^n - 1\\), which is non-zero only for odd \\(n\\).
Therefore, we will restrict the summation over \\(n\\) to only odd \\(n\\).

In order to map this solution to the original $z$-plane, we will consider \\(\phi(r,s)\\) as the real part of a complex function \\(f(r,s) = \phi(r,s) + i\psi(r,s)\\). With a little bit of complex analysis[^fn:1], we find that the function that solves the PDE specified on the 2D square is:

\\[
f(w) = \sum\_{n \text{odd}} \frac{iV}{n\pi\sinh(n\pi)}
\left[
\cosh\left(\frac{n\pi(w-a)}{a}\right) + \cosh\left(\frac{n\pi(iw - a)}{a}\right)
\right]
\\]


#### Transforming Back {#transforming-back}

Now to get the potential for the original geometry, we would need to compute the integral in \\((1)\\).

Unfortunately, this integral belongs to the class of [incomplete elliptic integrals](https://en.wikipedia.org/wiki/Elliptic%5Fintegral), which do not have a closed-form expression in terms of elementary functions.
But we can use numerical approximation to get close to the exact solution.

[^fn:1]: Since \\(f(r,s)\\) must satisfy the Cauchy Riemann equations, we can find one by inspection, but first it helps to re-write \\(\phi(r,s)\\) as a function of a single variable \\(w = r + is\\) and its conjugate \\(w^\*\\): \\[ \phi(w,w^\*) = \sum\_{n \text{odd}} \frac{iV}{n\pi\sinh(n\pi)} \left[ \cosh\left(\frac{n\pi(w-a)}{a}\right) + \cosh\left(\frac{n\pi(iw - a)}{a}\right) + \text{c.c.} \right] \\] This is helpful because the Cauchy Riemann equations can be written in terms of the [Wirtinger derivative](https://en.wikipedia.org/wiki/Wirtinger%5Fderivatives): \\[ \frac{\partial f}{\partial w^\*} = 0 \\] This makes finding \\(\psi\\) easy -- just choose a function that makes the resulting expression for \\(\phi + i\psi\\) free of terms involving \\(w^\*\\). By inspection, this is the \\(\text{c.c.}\\) term in the expression for \\(\phi\\). \\[ i\psi(w,w^\*) = -\sum\_{n \text{odd}} \frac{iV}{n\pi\sinh(n\pi)} \left[ \cosh\left(\frac{n\pi(w^\* - a)}{a}\right) + \cosh\left(\frac{n\pi(iw^\*-a)}{a}\right) \right] \\]
