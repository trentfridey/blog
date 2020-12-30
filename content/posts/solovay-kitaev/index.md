+++
title = "Universal Gates in Classical and Quantum Mechanics"
author = ["Trent Fridey"]
date = 2020-12-22
tags = ["quantum", "physics", "programming"]
draft = true
+++

## Introduction {#introduction}

Classical computers are based on _bits_, a set of binary variables \\(\\{x\_i | x \in \\{0, 1\\}\\}\\) and _logic gates_, which give classical computers their power.
There are many logic gates but the NAND gate is a _universal_ gate for classical computing because it can implement any of the other gates.

In quantum computing, not all of the classical logical gates are available.
This is because, unlike most classical computers today, quantum computers must implement reversible computation[^fn:1].
Further, quantum computers have additional logical gates not available to classical computers.
These include for example the Hadamard, Toffoli, and Z gates.

Yet it is still desirable that we identify which of the gates available to quantum computers are universal.
In other words, we would like to identify the (quantum) gates which (when taken individually or as a set) can implement any of the other gates.


## Proving Universality {#proving-universality}


### Classical Computing {#classical-computing}

In classical computing, we can prove that the NAND gate is capable of implementing any of the other logic gates by looking at its truth table:

\begin{array}{c|c|c}
 x & y & !(x \land y)  \newline
 0 & 0 & 1 \newline
 0 & 1 & 1 \newline
 1 & 0 & 1 \newline
 1 & 1 & 0 \newline
\end{array}


#### <span class="org-todo todo TODO">TODO</span> prove that the NAND gate is universal {#prove-that-the-nand-gate-is-universal}


### Quantum Computing {#quantum-computing}

In quantum computing, we work with qubits, which are vectors in \\(\mathbb{C}^2\\) with unit norm.
Single qubit gates are unitary matrices in \\(SU(2)\\)


#### <span class="org-todo todo TODO">TODO</span> derive a proof of the universal gate set {#derive-a-proof-of-the-universal-gate-set}


## <span class="org-todo todo TODO">TODO</span> Solovay-Kitaev {#solovay-kitaev}

[^fn:1]: This is a constraint that comes from the fact that quantum logic gates must be _unitary_, which is comes from the fundamentals of quantum theory.
