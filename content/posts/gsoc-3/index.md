+++
title = "QuTiP Virtual Lab Dev Log #3"
author = ["Trent Fridey"]
date = 2023-06-26
tags = ["quantum", "python", "javascript"]
draft = false
+++

This week in development of the QuTiP Virtual Lab, things are starting to take shape.
It's actually starting to look like an application.

But before I could devote 100% of my time to UI development, I had to take care of a couple of bugs with the compilation of QuTiP to WebAssembly.
When the application is built, it compiles QuTiP and its dependencies, and produces a WebAssembly module and a Javascript runtime.
Then, when the web app is run, the runtime gets bundled with the UI dependencies, like React and the graphing libraries, via a tool called `webpack`.
The issue I was having was with bundling the runtime with the other dependencies, because the runtime was using an older syntax.
While `webpack` is capable of transforming code (via plugins), I found that I could write a script to accomplish the same thing in a fraction of the time:

```javascript
  const fs = require("fs");
  const path = "./src/pyjs/pyjs_runtime_browser.js";
    fs.readFile(path, { encoding: 'utf-8'}, (err, data) => {
  const str = 'package'
  const regexs = [
    '(\\${)'+str+'(\\.filename})',
    '(\\${)'+str+'(\\.name})',
    '(,)'+str+'(\\))',
    '(\\()'+str+'(=>)'
  ]
  const toReplace = '$1pkg$2'
  let patched = data
  regexs.forEach(reg => {
    patched = patched.replace(new RegExp(reg, 'g'), toReplace)
  })
  patched = patched.replace("import(import_str)", ";");
  fs.writeFileSync(path, patched, {encoding: 'utf-8'})
  console.log("patched");
});
```

All this does is rename the variable `package` to `pkg`, and remove a dynamic import statement.
There are reasons for this but I will spare you, dear reader, the details.[^fn:1]


## Finally an App that Works {#finally-an-app-that-works}

Picking up from last week, I added the logic to call QuTiP when the ****Simulate**** button is pressed. According to my sketch, the button belongs to the section which also shows the details of the simulation, so I added a `Details.jsx` component with the code.

```javascript
import loadWasm from './loadWasm';
import demo from './demo';

export default function Details () {
    const [result, setResult] = useState('')
    const handleSimulate = async () => {
        const pyjs = await loadWasm(setResult)
        const main_scope = pyjs.main_scope()
        await pyjs.exec(demo);
    }
    return <div>
        <h2>Details</h2>
        <div>
            <BlockMath>
                {'\\mathcal{H} = \\lambda_1 \\sigma_x^{(1)}'}
            </BlockMath>
        </div>
        <button onClick={handleSimulate}>Simulate</button>
        <div>{JSON.stringify(result)}</div>
        </div>
}
```

The `loadWasm` function is the main workhorse here and it is responsible for loading the compiled QuTiP.
It returns a `pyjs` object, which is the Javascript runtime mentioned earlier.
To run Python code from this component, we just pass a valid Python script to the `pyjs.exec` function as a Javascript string. In the component above, `demo` is just the following code:

```python
from qutip import *;
import numpy as np;
psi = (2.0 * basis(2, 0) + basis(2, 1)).unit();
H = sigmaz();
times = np.linspace(0, 10, 100);
result = sesolve(H, psi, times, [sigmax(),sigmay(),sigmaz()]);
print(result.expect)
```

This code is just a demo of QuTiP's solver for the Schrodinger equation.
It solves the differential equation:

\\[
i\hbar\frac{d \psi(t)}{dt} = \sigma\_z \psi(t)
\\]

with initial condition

\\[
\psi(0) = \begin{pmatrix}
1/\sqrt{3} \\\\\\
2/\sqrt{3}
\end{pmatrix}
\\]

and returns the [Bloch vector](https://en.wikipedia.org/wiki/Bloch%5Fsphere) of the state for times between 0 and 100. The results are then piped back to the Javascript application as a string, the result of calling Python's `print` function.

With all this in place, I finally had an application that could run QuTiP in the browser, just by pressing a button!
After pressing ****Simulate****, I could watch the runtime load the WebAssembly in the browser inspector, run the simulation, and print the result.

{{< figure src="/ox-hugo/qutip-demo.gif" width="500px" >}}

Once I had this example in place, I refactored the application to support caching the runtime.
This was the other main problem I set out to tackle as of last week.
The solution was to load the `pyjs` object into React's [useRef](https://react.dev/reference/react/useRef) function.
This keeps the runtime in memory for the life of the application, but it also allows React to access it across renders.
As a result, the runtime should only be loaded once, which means the user will not have to wait as long.


## Next up: Inspecting the Results {#next-up-inspecting-the-results}

 Next week I will be focussing on adding more to the UI to support visualization of the results.
The Bloch sphere will be getting a companion graph, and there will be more to look at in my next development post as a result.

[^fn:1]: As it turns out, `package` is a future reserved word in the Javascript language, so using it as a variable name would cause a syntax error. The dynamic import statement is problematic for `webpack` because it messes with the bundling algorithm that resolves dependencies. This application doesn't actually need to use it, so we can just remove it from the source code.
