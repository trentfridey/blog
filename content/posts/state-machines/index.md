+++
title = "State Machines with XState"
author = ["Trent Fridey"]
date = 2020-11-14
tags = ["javascript", "front-end", "programming"]
draft = false
+++

## <span class="org-todo todo TODO">TODO</span> Introduction to State Machines {#introduction-to-state-machines}

The formal specification of a finite state machine requires 5 parts:

1.  The set of states \\(S\\)
2.  The set of events \\(\Sigma\\)
3.  The set of valid transitions \\(\delta: S\times\Sigma \to S\\)
4.  The initial state \\(s\_0\\)
5.  The set of final states \\(F\\)

Example


## <span class="org-todo todo TODO">TODO</span> Statecharts: an Extension to State Machines {#statecharts-an-extension-to-state-machines}

Statecharts are a group of extensions to state machines, that augment the features of state machines to make them easier to model.
These areas include hierarchy, concurrency, and communication.
Namely, in statecharts, you can have:

-   Hierarchical states
-   Orthogonal states
-   History states

or

statecharts = state-diagrams + depth + orthogonality + broadcast-communication


## <span class="org-todo todo TODO">TODO</span> An Example {#an-example}

Tracking a feature in software development from initialization to deployment

Represent it as a graph


## <span class="org-todo todo TODO">TODO</span> Implementing the Example with XState {#implementing-the-example-with-xstate}

XState is a Javascript library for implementing state machines in the browser.
Actually it implements state charts (an extension of state machines)
It is great because it follows a specification that has been sitting around for years as SCXML.

It allows us to generate an interactive representation of the state machine with `xstate-vis`.


### <span class="org-todo todo TODO">TODO</span> The Implementation {#the-implementation}

Include link to code sandbox?


## Notes {#notes}

Constructing a hieararch
