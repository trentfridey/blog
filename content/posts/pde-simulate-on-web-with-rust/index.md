+++
title = "Simulating PDEs on Web with Rust"
author = ["Trent Fridey"]
date = 2021-01-04
tags = ["rust", "webassembly", "PDEs", "front-end"]
draft = true
+++

We can use Rust and WebAssembly to simulate the solution to partial differential equations, using the browser as a front end.

In this post, we will implement a finite-difference solver in Rust that will compile to WebAssembly.


## Wait but why {#wait-but-why}

There are many, many ways to efficiently implement a finite-difference solver.
Even with JavaScript, we may be able to do so efficiently by leveraging the canvas APIs.
The benefit of using Rust is that we might be able to avoid the speed bottleneck of the canvas API by using lower-level APIs, while still having some guarantees about safety.


## Theoretical Background {#theoretical-background}

We will be solving the following PDE:

```rust

```
