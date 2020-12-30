+++
title = "Homotopy, Homology, Holonomy"
author = ["Trent Fridey"]
date = 2020-12-13
tags = ["math", "physics", "differential-geometry"]
draft = true
+++

## <span class="org-todo todo TODO">TODO</span> Introduction {#introduction}


## <span class="org-todo todo TODO">TODO</span> Homotopy {#homotopy}

Given a manifold \\(S\\), two paths \\(\gamma\_0, \gamma\_1 : [0,T] \to S\\) from \\(p\\) to \\(q\\) are **homotopic** if there exists a smooth function \\(\gamma\\):

\\[
  \gamma: [0,1] \times [0,T] \to S
  \\]

such that \\(\gamma(s, \cdot)\\) is a path from \\(p\\) to \\(q\\) for each \\(s\\) and

\\[
  \gamma(0,t) = \gamma\_0(t) \qquad \gamma(1,t) = \gamma\_1(t)
  \\]

-   [ ] Add illustration

    Such a function \\(\gamma\\) is a **homotopy** between \\(\gamma\_0\\) and \\(\gamma\_1\\).


## <span class="org-todo todo TODO">TODO</span> (Co)Homology {#co--homology}

Homology is used to study the number of 'holes' in a manifold via the operator \\(\partial\\).

For our purposes, it will be more coherent if we use cohomology, which is the same as homology, but it uses the exterior derivative, \\(\mathrm{d}\\).

A differential \\(p\\) -form \\(\beta\\) is **exact** if there exists some \\(p-1\\) -form \\(\alpha\\) such that \\(\beta = \mathrm{d}\alpha\\).

A differential \\(p\\) -form \\(\gamma\\) is **closed** if \\(\mathrm{d}\gamma = 0\\)

Note that all exact forms are closed:

\\[
  \mathrm{d}\beta = \mathrm{d}^{2}\alpha = 0
  \\]

But not all closed forms are exact. The reason this is true is that not every manifold is simply connected -- in other words, there are obstructions to _homotopy_. To find a form \\(\eta\\) for which \\(\gamma = \mathrm{d}\eta\\), we would turn to Stokes' theorem:

\\[
 \oint\_{\partial\Omega} \gamma = \int\_{\Omega} \mathrm{d}\gamma = \int\_{\Omega} \eta
  \\]

If \\(\Omega\\) is not simply connected, then there would be a hole in the domain of the integral


## Holonomy {#holonomy}

If \\(\gamma: [0, T] \to M\\) is a smooth path from \\(p\\) to \\(q\\) in the manifold \\(M\\), and \\(E\\) is a vector bundle with connection \\(D\\), given \\(u \in E\_p\\), then

\\[
  H(\gamma, D)u
  \\]

is the result of parallel transporting \\(u\\) to \\(q\\) along path \\(\gamma\\). The function \\(H(\gamma, D)\\) is the **holonomy**.


## Example: Aharonov-Bohm Phase {#example-aharonov-bohm-phase}

Let the manifold \\(M\\) be:

\\[
M = \mathbb{R}^3 - \\{(0,0,z) | z \in \mathbb{R} \\}
\\]

There is an obstruction to homotopy of the paths:

\\[
\gamma\_0(t) = (\cos(\pi t), \sin(\pi t), 0) \qquad \gamma\_1(t) = (\cos(\pi t), -\sin(\pi t), 0)
\\]

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

-   [ ] solve for \\(A\\) of a solenoid

Then \\(e^{i\oint\_\gamma A}\\) is the Aharonov-Bohm phase seen in the [Aharonov-Bohm effect](https://en.wikipedia.org/wiki/Aharonov%E2%80%93Bohm%5Feffect).
