+++
title = "Inverting a Moving Average Time Series"
author = ["Trent Fridey"]
date = 2021-10-30
draft = false
+++

Consider a discrete time series \\(\\{X\_t  |  t = 0, 1, 2, \ldots\\}\\) where the \\(X\_t\\) could be either deterministic (like samples from a sine wave) or a random variable. We can form a _simple moving average_ from this time series by defining a new time series \\(Y\_t\\), where:

\begin{equation\*}
Y\_t = \frac12 \left(X\_t + X\_{t-1} \right)
\end{equation\*}

i.e. \\(Y\_t\\) represents the average of the current value of \\(X\_t\\) and the previous value, \\(X\_{t-1}\\).

Using a moving average instead of the base series has many applications in the real world -- signal processing, finance, etc., because it is usually considered an easy way to smooth the underlying signal \\(X\_t\\).

This post shows how to invert this smoothing process, so that we can recover the underlying signal \\(X\_t\\) from the smoothed signal \\(Y\_t\\).


## Inverting the simple moving average {#inverting-the-simple-moving-average}

To invert a simple moving average, first we define the **shift operator** \\(B\\), in terms of its action on a discrete time series:

\begin{equation\*}
B X\_t = X\_{t-1}
\end{equation\*}

that is, it shifts the time index of \\(X\\) back one step (\\(t \to t-1\\)). Therefore we can rewrite the moving average \\(Y\_t\\) as:

\begin{equation\*}
Y\_t = \frac12 (1+B)X\_t
\end{equation\*}

In this form, we might guess that solving for \\(X\_t\\) for would just be a matter of dividing both sides by \\(\frac12 (1+B)\\):

\begin{equation\*}
\frac{2}{1+B} Y\_t = X\_t
\end{equation\*}

However, since \\(B\\) is an _operator_ and not a plain _number_, we need to make sense of what \\(B\\) being in the denominator means. The typical way to do this is to use the [geometric series representation](https://en.wikipedia.org/wiki/Geometric%5Fseries)[^fn:1] to write the fraction as a infinite sum:

\begin{equation\*}
\frac{1}{1+B} = \sum\_{k=0}^{\infty} (-1)^k B^k
\end{equation\*}

where \\(B^k\\) is just the application of \\(B\\) to the series \\(k\\) times:

\begin{equation\*}
B^k X\_t = X\_{t-k}
\end{equation\*}

Therefore, the solution should be understood as:

\begin{align\*}
X\_t &= 2\sum\_{k=0}^\infty (-1)^k B^k Y\_t \\\\\\
 &= 2\sum\_{k=0}^\infty (-1)^k Y\_{t-k}
\end{align\*}


## Generalization to higher-order moving averages: {#generalization-to-higher-order-moving-averages}

If we write the original moving average as:

\begin{equation\*}
Y\_t = \frac12 \sum\_{k=0}^{1} X\_{t-k}
\end{equation\*}

then we can generalize to a _moving average of order_ \\(q\\), which is abbreviated MA(q):

\begin{equation\*}
Y\_t = \frac{1}{q} \sum\_{k=0}^{q-1} X\_{t-k}
\end{equation\*}

Inverting this series is similar to the simple moving average. First, rewrite \\(Y\_t\\) in terms of the shift operator \\(B\\):

\begin{equation\*}
\frac{1}{q}\sum\_{k=0}^{q-1} X\_{t-k} = \frac{1}{q} \left(\sum\_{k=0}^{q-1} B^k\right) X\_t
\end{equation\*}

Using our trick from earlier (but going in the opposite direction), the term in parenthesis can be written as a fraction:

\begin{equation\*}
\sum\_{k=0}^{q-1}B^k = \frac{1-B^{q}}{1-B}
\end{equation\*}

which allows us to solve for \\(X\_t\\) by multiplying both sides by the reciprocal:

\begin{equation\*}
X\_{t} = q\frac{1-B}{1-B^q}Y\_t
\end{equation\*}

and from here, we expand the denominator as an infinite sum:

\begin{align\*}
X\_t &= q (1-B)\sum\_{k=0}^{\infty}B^{kq} Y\_t \\\\\\
    &= q \sum\_{k=0}^\infty (B^{qk} - B^{qk + 1}) Y\_t \\\\\\
    &= q \sum\_{k=0}^\infty (Y\_{t-qk} - Y\_{t-(qk+1)}) \\\\\\
\end{align\*}


### Sanity check {#sanity-check}

Sanity checks are always helpful. Believe it or not, I actually made a mistake the first time I wrote this. So, does this reduce to the previous solution in the case \\(q = 2\\)? The answer is yes:

\begin{align\*}
X\_t &= 2\sum\_{k=0}^\infty (Y\_{t-2k} - Y\_{t-2k-1}) \\\\\\
   &= 2\left(Y\_{t} - Y\_{t-1} + Y\_{t-2} - Y\_{t-3} + \ldots  \right) \\\\\\
   &= 2\sum\_{k=0}^\infty (-1)^k Y\_{t-k}
\end{align\*}

QED

[^fn:1]: The mathematicians here will be worried about whether the infinite sum converges. I can assure you, it can be proven, but I have no interest in doing that here. If you're interested, this kind of analysis belongs to [operator theory](https://en.wikipedia.org/wiki/Operator%5Ftheory)
