+++
title = "Simple Retirement Planning"
author = ["Trent Fridey"]
date = 2020-11-01
draft = false
+++

## Introduction {#introduction}

Simple principle: as long as returns from investments are greater than expenses, working for pay is not necessary


## Derivation {#derivation}

-   Let monthly expenses at retirement be \\(C\\)
-   Let monthly returns from investments be \\(R(t)\\)
-   When \\(R(t^\*) \geq C\\), then \\(t^\*\\) is the retirement age (in months)

The expression for \\(R(t)\\) in terms of known values:

-   Savings rate \\(S\\) is the dollar amount put into investments each month
-   Interest rate \\(r\\) is the percent increase in value of investments given for a month
-   Existing capital \\(P\_0\\) is the amount of money that is initial invested

After \\(t\\) months, the capital will appreciate to:

\\[
  P(t) = P\_0(1+r)^t + \sum\_{k=1}^t S(1+r)^{t-k}
  \\]

So that the return after \\(t\\) months is \\(R(t) = P(t) - P(t-1)\\)

\\[
  R(t)
  = P\_0r(1+r)^{t-1} + S\left(1+r\sum\_{k=1}^{t-1}(1+r)^{t-k-1}\right)
  \\]


## Plots {#plots}

```python
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.ticker as ticker
plt.style.use('grayscale')

def retire(t,P,S,r):
    return P*r*(1+r)**(t-1) + S*(1 + r*sum([(1+r)**(t-k-1) for k in range(1,t)]))

t = range(1,15*12)

fig, ax = plt.subplots()

ax.plot(t, [retire(q,60000,2000,0.06/12) for q in t], label=r"$6\%$")
ax.plot(t, [retire(q,60000,2000,0.08/12) for q in t], label=r"$8\%$")
ax.plot(t, [retire(q,60000,2000,0.10/12) for q in t], label=r"$10\%$")

formatter = ticker.FormatStrFormatter('$%1.2f')
ax.yaxis.set_major_formatter(formatter)
ax.legend()

ax.set_title(r"$R(t) = P(t)-P(t-1)$")
ax.set_xlabel(r"$t$ (months)")
ax.grid()
fig.tight_layout()
fig.savefig(name)
return name
```

What is interesting is if we allow for the savings rate to increase with time -- where we make a 5% increase in our savings rate year over year.

```python
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.ticker as ticker
plt.style.use('grayscale')

def retire(t,P,S,r):
    return P*r*(1+r)**(t-1) + S*(1 + r*sum([(1+r)**(t-k-1) for k in range(1,t)]))

t = range(1,15*12)

fig, ax = plt.subplots()

ax.plot(t, [retire(q,60000,(2000 * (1 + 0.05/12)**q),0.06/12) for q in t], label=r"$6\%$ + 5% yearly increase")
ax.plot(t, [retire(q,60000,2000,0.08/12) for q in t], label=r"$8\%$")
ax.plot(t, [retire(q,60000,2000,0.10/12) for q in t], label=r"$10\%$")

formatter = ticker.FormatStrFormatter('$%1.2f')
ax.yaxis.set_major_formatter(formatter)
ax.legend()

ax.set_title(r"$R(t) = P(t)-P(t-1)$")
ax.set_xlabel(r"$t$ (months)")
ax.grid()
fig.tight_layout()
fig.savefig(name)
return name
```


## Conclusion {#conclusion}

In this post we explored the simple math behind retirement planning, and found that a lower interest rate can approximate the growth of a higher interest rate by increasing the savings rate year over year.
