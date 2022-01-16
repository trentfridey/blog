+++
title = "The ‘No Free Lunch’ Theorem"
author = ["Trent Fridey"]
date = 2021-12-13
tags = ["math", "data-science", "supervised-learning"]
draft = false
+++

In this post, I'd like to share the answer to the natural question that arises when one first becomes acquianted with supervised machine learning: _why are there so many different ways to solve supervised learning_?

A quick glance at [scikit-learn](https://scikit-learn.org/stable/), the (most?) popular machine-learning library shows there are at least 8:

1.  Linear models
2.  Support Vector Machines
3.  Nearest Neighbors
4.  Gaussian Processes
5.  Cross decomposition
6.  Naive Bayes
7.  Decision Trees
8.  Neural Networks

At first glance, one might wonder why there are so many methods to accomplish the same task.
If we've found multiple ways to solve the supervised learning task, are some methods better than others?
Is there a "best" method that can outperform all the others for an arbitrary data set in supervised learning?

_Unfortunately, the answer to this question is no._
This result is called the **"No Free Lunch Theorem"** for supervised learning.
As a result of this, we can't hope to label one of the algorithms above as "the best" without knowing anything about the data.
Worse, we can't hope to invent a better supervised learning algorithm that is universally better than the eight listed above.

For the impatient, I'll quote the result from [the original paper](https://direct.mit.edu/neco/article-abstract/8/7/1341/6016/The-Lack-of-A-Priori-Distinctions-Between-Learning) here:

>
>
> The primary importance of the NFL theorems is their implication that, for any two learning algorithms \\(A\\) and \\(B\\) ... there are just as many situations (appropriately weighted) in which algorithm \\(A\\) is superior to algorithm \\(B\\) as vice versa... This is true even if algorithm \\(B\\) is the algorithm of purely random guessing.

By making a statement about all possible supervised learning algorithms, we're assuming that all supervised learning algorithms share some essential ingredients.
To see that this is the case, let's define what we mean by supervised learning:

**Supervised Learning:** Given a data set \\(d = \left\\{ (\vec{x}\_i, y\_i)\_{i=0}^N\right\\}\\) sampled from \\(f\\) (the _target_ distribution), which is composed of pairs \\((\vec{x}\_i, y\_i)\\), where \\(\vec{x}\_i\\) is the _data_ belonging to some _input space_ \\(X\\), and \\(y\_i\\) is the associated _output_ in the _output space_ \\(Y\\), find the conditional probability distribution \\(h(Y|X)\\) that best approximates the target distribution, according to some _loss function_ \\(L\\).

For example, a common loss function is the quadratic loss: \\(L(y\_H, y\_F) = (y\_H - y\_F)^2\\).
The evaluation of the loss function is the cost, \\(c\\), i.e. \\(c = L(y\_H, y\_F)\\).
Any supervised learning method then seeks to adjust \\(h\\) so to minimize the cost on the training set.
When it is done training, the method will output its best hypothesis distribution, and we will evaluate the performance of the algorithm by computing the loss function using the test data set.
This quantity is called the _off-training-set cost_, or \\(c\_{OTS}\\), and it will be how we compare the performance of two supervised learning methods.


## Recasting the Question Using Symbols {#recasting-the-question-using-symbols}

Now that we have all the ingredients of supervised learning, we can recast the question introduced earlier in terms of the ingredients of a supervised learning task.

The question becomes: "What is the difference in the expected value of the cost \\(c\_{OTS}\\) between two supervised learning algorithms \\(A\\) and \\(B\\), for a given data set \\(d\\), when averaged over all possible target distributions \\(f\\)?"

Therefore let us define \\(\Delta\\) as:

\begin{equation\*}
\Delta = E\_A[c\_{OTS}|f,d] - E\_B[c\_{OTS}|f,d]
\end{equation\*}

If \\(A\\) performs better over all possible target distributions \\(f\\) than \\(B\\), when both are given the same data set \\(d\\), then this quantity will be less than zero when averaged over all \\(f\\), and we should always use method \\(A\\) over \\(B\\).

If \\(A\\) and \\(B\\) perform equally well over all possible target distributions \\(f\\), then \\(\Delta\\) will be zero when averaged over all \\(f\\).

We seek then to evaluate the average of \\(\Delta\\) over all \\(f\\):

\begin{equation\*}
\int \Pr(f) \Delta df
\end{equation\*}

In order to do this, we can use the extended bayesian framework[^fn:1].
As it turns out, this quantity can be shown to be zero under all conditions relevant to supervised learning.
As a result, since we did not specify which algorithm is \\(A\\) and which is \\(B\\), we can conclude that \\(\Delta\\) is zero for all possible supervised learning algorithms.


## Implications {#implications}

The implications of this result is that, for a given task in supervised learning, we cannot state ahead of time which method is going to perform the best in approximating the target distribution \\(f\\).
All methods are equally likely to perform well before we start testing.
This is why data scientists need to train multiple methods at once, and only after doing this are they able to find the best method.


## Conclusion {#conclusion}

In this post, we asked and answered the common yet important question regarding supervised learning methods -- namely, why are there so many?
We saw that all the supervised learning methods have the same ingredients: \\(f,d,h,c\\), and that we can gauge the relative performance of two algorithms based on the off-training-set cost.
By considering the space of all possible target distributions and the extended Bayesian framework, we see that we cannot determine _a priori_ which method is better at approximating the target distribution.

[^fn:1]: From [The Mathematics of Generalization](https://www.google.com/books/edition/The%5FMathematics%5FOf%5FGeneralization/6GdQDwAAQBAJ?hl=en&gbpv=1&printsec=frontcover)
