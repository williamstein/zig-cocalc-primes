# Use Zig in CoCalc

CoCalc now supports the [programming language zig](https://ziglang.org/).  (Use the Experimental software environment as of Aug 12, 2021, but this will be default in a few days.)

- You can edit files that end in .zig and get syntax highlighting (from C) and formatting (by ctrl+shift+f) using `zig fmt`.
- The `zig` command line program is pre-installed.
- You can also click +New --&gt; VS Code server, and run Visual Studio Code Server in another tab.
  - Install the zig extension from the extension marketplace (which takes about 5 seconds), then
  - Referesh your VS Code browser tab.

## Example: counting primes with a sieve

<img src=".README.md.upload/Screen Shot 2021-08-12 at 11.45.45 AM.png"   width="960px"  height="485.797px"  style="object-fit:cover"/>

<br/>
<br/>
<br/>

[Browse code here](./)

I created two examples of zig programs for counting primes, starting from [this](https://rosettacode.org/wiki/Sieve_of_Eratosthenes#Zig).

1. zig-static - uses static memory on the stack to compute $\pi(n)$ for some values of $n$.  Native only works in debug mode (the default); crashes when built with `-O ReleaseFast` .  WASM works in ReleaseFast mode.
2. zig-dynamic - uses dynamically allocated memory to compute $\pi(n)$ for some values of $n$.

In each case we include comments about how to compile and run these natively locally, and also using web assembly.

Timings are roughly:

- sieve: native in debug mode: 0.16s; wasm in debug mode: 0.17s; wasm in ReleaseFast mode: 0.09s;
- sieve2 in ReleaseFast mode: 0.05s; wasm 0.06s.

For comparison, I've also included the dynamically allocated computation in C, Javascript and Python, where timings are as follows.  You can find those in the corresponding subdirectories.

- C - 0.05s.
- Javascript - 0.13s
- Python - 2s
