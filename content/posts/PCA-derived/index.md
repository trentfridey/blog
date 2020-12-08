+++
title = "Principal Component Analysis"
author = ["Trent Fridey"]
date = 2020-11-14
tags = ["data-science", "math"]
draft = false
+++

## Introduction {#introduction}

Principal component analysis, or PCA, is used to characterize a highly multi-dimensional data set in terms of its main sources of variation.
It is a _dimensionality-reduction_ technique, which helps to avoid the curse of dimensionality.
Here's the main idea:

Let's say we have a \\(n\\) - dimensional distribution with random variables \\(X\_1, X\_2, \dots, X\_n\\).
We can take these variables to be uncorrelated, with mean zero, without loss of generality.
If we take \\(N\\) samples from this distribution, we can calculate the sample variances:

\\[
  \widehat{\sigma^2\_{x\_i}} = \frac{1}{N-1}\sum\_{j=1}^N x\_{ij}^2 - \bar{x\_i}^2
  \\]

Let's say we find that among the \\(\widehat{\sigma^2\_{x\_i}}\\), the sample variance \\(\widehat{\sigma^2\_{x\_3}}\\) is the smallest.
In the limit that \\(\widehat{\sigma^2\_{x\_3}} = 0\\), there is no variation in the \\(X\_3\\) variable.
In this case, we could remove the variable from our sample set, and our models would perform just as well.

If we did this, the data set effectively becomes $(n-1)$-dimensional! 🎉

If we have \\(k\\) variables with sample variance zero, we could remove those as well, making our data set $(n-k)$-dimensional! 🤯

Usually, we don't find that the sample variance is zero in any of our variables, so we approximate by removing the variable(s) with the least variance. The remaining variable(s) are called the **principal components**.


### Adding Correlations {#adding-correlations}

There are complications when there are correlations between the variables. Here's a 2-dimensional data set to illustrate the issue:

```python
import matplotlib.pyplot as plt
import numpy as np


fig, ax = plt.subplots()
ax.plot(x, y, marker="o", ls="", color="black")
ax.grid()
ax.set_title('A Random Distribution of points in 2D')
ax.set_xlim(-10, 10)
ax.set_ylim(-10,10)
ax.set_xlabel('x')
ax.set_ylabel('y')
fig.tight_layout()

```

{{< figure src="/ox-hugo/prePCA.png" >}}

We can calculate the sample variance of each of the variables as:

$$\widehat{\sigma^2_x} = 6.39, \qquad \widehat{\sigma^2_y} = 3.3$$

It looks like the variable with the lowest variance is the \\(y\\) variable.
But there is a slight positive correlation in this data set.
In fact, if we calculate the sample variance along the direction of \\(\vec{e}\_1 = \frac{1}{\sqrt2} \hat{i} + \frac{1}{\sqrt2} \hat{j}\\):

\\[
  \widehat{\sigma^2\_{\vec{x}\cdot\vec{e}\_1}} =
  \frac{1}{2}\widehat{\sigma^2\_x} +
  \frac{1}{2}\widehat{\sigma^2\_y} +
  \widehat{\text{Cov}}(x,y)
  \\]

We find that

$$\widehat{\sigma^2_{\vec{x}\cdot\vec{e}_1}} = 0.93$$

Note that
\\[
  \widehat{\sigma^2\_{\vec{x}\cdot\vec{e}\_1}} < \widehat{\sigma^2\_y}
  \\]

Therefore, when the variables are correlated, a _linear combination of variables_ may have less variance than any individual variable. In our example, we can define \\(y' = \frac{1}{\sqrt{2}}x + \frac{1}{\sqrt{2}}y\\) as a factor in a _new_ 2D model, which has variables \\((x', y')\\).

To define \\(x'\\), we can form a vector perpendicular to \\(\vec{e}\_1\\), that is, the vector \\(\vec{e}\_2 = -\frac{1}{\sqrt{2}}\hat{i} + \frac{1}{\sqrt{2}}\hat{j}\\). Calculating the variance along this vector, we find:

$$\widehat{\sigma^2_{\vec{x}\cdot\vec{e}_2}} = 8.76$$

And note that:

\\[
  \widehat{\sigma^2\_{\vec{x}\cdot\vec{e}\_2}} > \widehat{\sigma^2\_x}
  \\]

So \\(\vec{e}\_2\\) captures more of the variance than the \\(x\\) variable by itself.

Therefore, in this 2D data set, \\(x'\\) would be the principal component, and we would remove \\(y'\\) from our models.


### Generalizing {#generalizing}

We can generalize this by parameterizing the vectors in terms of a dummy variable \\(\theta\\):

\\[
  \vec{e\_1} = \cos(\theta)\hat{i} +\sin(\theta)\hat{j}
  \\]

\\[
  \vec{e\_2} = \sin(\theta)\hat{i} - \cos(\theta)\hat{j}
  \\]

The expression for the sample variance is then:

\\[
  \widehat{\sigma^2\_{\vec{x}\cdot\vec{e\_1}}} = \cos^2(\theta)\widehat{\sigma\_x^2} + \sin^2(\theta)\widehat{\sigma^2\_y} + \sin(2\theta)\widehat{\text{Cov}}(x,y)
  \\]

We can find the components by maximizing this expression with respect to \\(\theta\\):

\\[
  \theta^{\*} = \text{arg}\max\_\theta \widehat{\sigma^2\_{\vec{x}\cdot\vec{e\_1}}}
  \\]

Since this example is in 2D, we only have to find one parameter. But in $d$-dimensions, we would need \\((d-1)\\) parameters. So let's find a better way.


#### Inspiration from Geometry {#inspiration-from-geometry}

If you squint, the expression we tried to maximize looks like the equation for an ellipse:

\\[
    0 = a x^2 + c y^2 + 2bxy
    \\]

and if we remember our geometry, the principal axes of such an ellipse can be derived from the _eigenvectors_ of the corresponding matrix:

\\[
    A = \begin{pmatrix} a & b \\\ b & c \end{pmatrix}
    \\]

Further, this method works for $n$-dimensional ellipsoids. Therefore, if we could make the correspondence exact, the problem of finding the vectors \\(\vec{e\_1}, \vec{e\_2}, \dots, \vec{e\_n}\\) could be reduced to finding the eigenvectors of a specific matrix.

Fortunately, we have such a matrix readily available: consider rewriting the expression as:

\\[
    \vec{e\_1} = \begin{pmatrix} \cos\theta & \sin\theta \end{pmatrix}
    \\]
\\[ M = \begin{pmatrix} \widehat{\sigma\_x^2} & \widehat{\text{Cov}}(x,y) \\\ \widehat{\text{Cov}}(y,x) & \widehat{\sigma\_y^2} \end{pmatrix}
    \\]

\\[
     \widehat{\sigma^2\_{\vec{x}\cdot\vec{e\_1}}} = \vec{e\_1}^T M \vec{e\_1}
    \\]

\\(M\\) is just the _sample covariance matrix_. Therefore, in order to find the principal components for any dimensional data set, we will use the eigenvectors of the sample covariance matrix. Once we have calculated them, we can identify the components with the least variance, and remove them.


## Conclusion {#conclusion}

We can summarize the above into the following algorithm:

1.  Calculate the sample covariance matrix
2.  Find the eigenvectors of said matrix
3.  Remove (or ignore) the components which have the least variance

What you end up with is a smaller-dimensional data set, while still capturing most of the variation in the data. The components then can be used for model building, but that is a subject for a different post.
