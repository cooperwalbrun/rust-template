# rust-template ![master](https://github.com/cooperwalbrun/rust-template/workflows/master/badge.svg) [![codecov](https://codecov.io/gh/cooperwalbrun/rust-template/branch/master/graph/badge.svg?token=SFH1NL79H4)](https://codecov.io/gh/cooperwalbrun/rust-template)

1. [Checklist](#checklist)
2. [Overview](#overview)
3. [Contributing](#contributing)

## Checklist

>Did you just clone this repository? Here is a checklist of things you should change before you get
>started developing!

1. Remove the `Cargo.lock` line from the `.gitignore` if your project will be an executable. See
   [the Rust FAQs](https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-in-version-control-but-not-libraries)
   for more information.
2. Rename `src/main.rs` to `src/lib.rs` (and remove the `main` function) if your project is NOT an
   executable (i.e. it is a library). Likewise, be sure to remove all mentions of `run` command(s)
   from the `CONTRIBUTING.md`.
3. Update other files according to your project's needs (e.g. `Cargo.toml`, `README.md`,
   `CODEOWNERS`, etc).

## Overview

This is a template repository. It comes with support for the following:

* Support for all the items below on both Windows and Linux
* Linting via [rust-clippy](https://github.com/rust-lang/rust-clippy)
* Formatting via [rustfmt](https://github.com/rust-lang/rustfmt)
* Unit testing
* Code coverage analysis and "pretty" coverage reporting via
  [cargo-llvm-cov](https://github.com/taiki-e/cargo-llvm-cov)
* Execution analysis of Undefined Behavior via [Miri](https://github.com/rust-lang/miri)
* Orchestration of *all the above* via [cargo-make](https://github.com/sagiegurari/cargo-make)
(see [CONTRIBUTING.md](CONTRIBUTING.md) for details)

This repository also includes other features which are not necessarily specific to Rust, but they
have been added for demonstrative purposes:

* Sample [Codecov](https://app.codecov.io) configuration
* Execution of unit testing-, code coverage-, and Codecov-oriented tasks in an automated fashion via
  [GitHub Actions workflows](https://docs.github.com/en/actions)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for developer-oriented information.
