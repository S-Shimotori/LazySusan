# LazySusan

:ramen:

Dockerfile for [EZCSP](http://www.mbal.tk/ezcsp/index.html) and depended programs on Ubuntu yakkety to define @S-Shimotori 's research environment.

The Dockerfile has a command to install dlv_rsig(See EZCSP's page) to build EZCSP.
It also includes [gringo](http://potassco.sourceforge.net/#gringo), [clasp](http://potassco.sourceforge.net/#clasp), [mkatoms](http://www.mbal.tk/mkatoms/) and CP solvers([BProlog](http://www.picat-lang.org/bprolog/index.html) and [SWIProlog](http://www.swi-prolog.org/)) to run.

|programs|version|
|---|---|
|EZCSP|1.7.9|
|dlv_rsig|1.8.10|
|clingo|5.2.0|
|mkatoms|2.16|
|BProlog|7.5(EZCSP recommends)|
|SWIProlog|7.2.3+dfsg-1build2|

## What's EZCSP?

> EZCSP is an inference engine that allows computing extended answer sets of ASP programs, as defined in [[bal09a](https://pdfs.semanticscholar.org/e13d/711d06959d0ae074865374f629fbf18e29cf.pdf),[bal09b](https://pdfs.semanticscholar.org/509e/aa7f9dca8bb9263197c8eddb45cbfdb00d44.pdf)].

Run `ezcsp` with an option specifying CP solver.

```sh
ezcsp --sicstus3 hoge.ez
ezcsp --bprolog hoge.ez
ezcsp --swiprolog hoge.ez
ezcsp --gams hoge.ez
```

