+++
title = "Homotopy, Homology, Holonomy"
author = ["Trent Fridey"]
date = 2020-12-13
tags = ["math", "physics", "differential-geometry"]
draft = false
+++

## Homotopy {#homotopy}

The geometric idea of homotopy is an interpolation between two paths on a manifold which share the same start and end point.

{{< figure src="/ox-hugo/homotopy.svg" >}}

Mathematically speaking, given a manifold \\(S\\) and two fixed points \\(p\\) and \\(q\\) on the manifold, two paths \\(\gamma\_0, \gamma\_1 : [0,T] \to S\\) are **homotopic** if there exists a smooth function \\(\gamma\\):

\\[
  \gamma: [0,1] \times [0,T] \to S
  \\]

such that \\(\gamma(s, \cdot)\\) is a path from \\(p\\) to \\(q\\) for each \\(s\\) and

\\[
  \gamma(0,t) = \gamma\_0(t) \qquad \gamma(1,t) = \gamma\_1(t)
  \\]

Such a function \\(\gamma\\) is a **homotopy** between \\(\gamma\_0\\) and \\(\gamma\_1\\).

Things start to get interesting if we have a manifold where there is an obstruction to homotopy.
This can happen if the manifold has 'holes' in it.


## (Co)Homology {#co--homology}

Cohomology is a way to study "holes" by looking at [differential forms](https://en.wikipedia.org/wiki/Differential%5Fform) on manifolds.

A differential \\(p\\) -form \\(\omega\\) is **closed** if \\(\mathrm{d}\omega = 0\\)
A differential \\(p\\) -form \\(\beta\\) is **exact** if there exists some \\(p-1\\) -form \\(\alpha\\) such that \\(\beta = \mathrm{d}\alpha\\).

Note that all exact forms are closed:

\\[
  \mathrm{d}\beta = \mathrm{d}^{2}\alpha = 0
  \\]

But not all closed forms are exact.
The reason this is true is that not every manifold is simply connected -- in other words, there are obstructions to _homotopy_.
If \\(\Omega\\) is not simply connected, then the integral of a closed form around a loop could be non-zero, which breaks Stokes theorem.


## Holonomy {#holonomy}

The idea of a holonomy is a measure of the curvature of a manifold by inspecting the change in a vector as it is transported along a closed loop.
This geometric notion is best described through a picture:

{{< figure src="/ox-hugo/holonomy.svg" >}}

The tangent vector \\(u\\) is pushed along the loop \\(\gamma\\) on the sphere \\(M\\).
The progression is indicated by a change in color, from red to orange, yellow, green, to blue.
As it completes the loop, it ends up pointing in a different direction only because the sphere is curved.

Mathematically speaking, if \\(\gamma: [0, T] \to M\\) is a smooth path from \\(p\\) to \\(q\\) in the manifold \\(M\\), and \\(E\\) is a vector bundle with connection \\(D\\), given \\(u \in E\_p\\), then

\\[
  H(\gamma, D)u
  \\]

is the result of parallel transporting \\(u\\) to \\(q\\) along path \\(\gamma\\). The function \\(H(\gamma, D)\\) is the **holonomy**.


## Application: Aharonov-Bohm Phase {#application-aharonov-bohm-phase}

Let the manifold \\(M\\) be:

\\[
M = \mathbb{R}^3 - \\{(0,0,z) | z \in \mathbb{R} \\}
\\]

This is the usual three dimensional space, except there is a 'hole' along the vertical axis.

There is an obstruction to homotopy of the paths:

\\[
\gamma\_0(t) = (\cos(\pi t), \sin(\pi t), 0) \qquad \gamma\_1(t) = (\cos(\pi t), -\sin(\pi t), 0)
\\]

Which can be visualized below:

{{< figure src="/ox-hugo/obstruction.svg" >}}

There's no way to smoothly deform \\(\gamma\_1\\) into \\(\gamma\_2\\) while keeping \\(p\\) and \\(q\\) fixed -- you can't get around the void at the origin!

In other words, we can find a 1-form \\(A\\) such that:

\\[
\oint\_\gamma A \neq 0
\\]

for some smooth closed path \\(\gamma: [0,T] \to M\\), \\(\gamma(0) = \gamma(T)\\)

If we form the \\(G\\) -bundle \\(E = M \times V\\) where \\(V\\) is the vector space of the representation of the group \\(U(1)\\), then the _holonomy_:

\\[
H(\gamma, D)u = e^{i\oint\_\gamma A} u
\\]

describes the resulting wavefunction \\(u\\) of a quantum particle after being parallel transported around a loop \\(\gamma\\) in the base space.

Choosing \\(\gamma = (\cos(2\pi t), \sin(2\pi t), 0)\\) as the path, and the one-form as:

\\[
A = \frac{2\pi}{r}\mathrm{d}\theta
\\]

Then \\(e^{i\oint\_\gamma A}\\) is the Aharonov-Bohm phase seen in the [Aharonov-Bohm effect](https://en.wikipedia.org/wiki/Aharonov%E2%80%93Bohm%5Feffect).
