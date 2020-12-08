+++
title = "Statistics of NPS"
author = ["Trent Fridey"]
date = 2020-10-06
tags = ["statistics"]
draft = false
+++

## Introduction {#introduction}

A common benchmark for businesses these days is the _Net Promoter Score_ or NPS.
It measures how likely your customers are to recommend you product or business to someone else.
NPS is usually measured by customer responses to the question:

> On a scale of one to ten, how likely are you to recommend our product (or business) to someone else?


## Definition {#definition}

The responses to the survey are sorted into three categories: promoters, passives, and detractors.
Responses with a rating of 9 or 10 are promoters; those with a rating of 7 to 8 are passives; those with 6 or below are detractors.
The NPS is then calculated as the difference in the proportion of promoters from detractors:

\\[
  NPS = p\_{+} - p\_{-}
  \\]

In most real-world surveys of NPS, you may only get responses from a small fraction of your customer base.
In surveys where the responses represent only a fraction of the total population, the NPS statistic is only an estimate of the true NPS.
In the notation, we represent this by putting a \\(\hat{\cdot}\\) over the variable.
In order to be more informative, we can calculate confidence intervals on the true NPS value.


## Confidence Intervals {#confidence-intervals}


### <span class="org-todo todo TODO">TODO</span> Sampling Distribution of NPS {#sampling-distribution-of-nps}

In cases where the number of responses are large enough[^fn:1], we can use the central limit theorem to model the NPS estimator as a normal variable.

\\[
  \text{Pr}\left(-t\_{\alpha/2} < \frac{\hat{p}\_+ - \hat{p}\_- - NPS}{\sigma\_p} < t\_{\alpha/2}\right) = 1 - \alpha
  \\]

\\[
  \text{Pr}((\hat{p}\_+ - \hat{p}\_-) - \sigma\_p t\_{\alpha/2} < NPS < (\hat{p}\_+ - \hat{p}\_-) - \sigma\_p t\_{\alpha/2}) = 1 - \alpha
  \\]


## Hypothesis Testing {#hypothesis-testing}


### <span class="org-todo todo TODO">TODO</span> Testing population variances with F-statistic {#testing-population-variances-with-f-statistic}

[^fn:1]: This is the case when \\(np(1-p) \gtrsim 5\\)
