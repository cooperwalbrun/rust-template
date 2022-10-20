# YOUR PROJECT NAME HERE ![master](https://github.com/cooperwalbrun/rust-template/workflows/master/badge.svg) [![codecov](https://codecov.io/gh/cooperwalbrun/rust-template/branch/master/graph/badge.svg?token=SFH1NL79H4)](https://codecov.io/gh/cooperwalbrun/rust-template)

1. [Checklist](#checklist)
2. [Overview](#overview)
3. [Contributing](#contributing)

## Checklist

>Did you just clone this repository? Here is a checklist of things you should change before you get
>started developing!

1. Remove the `Cargo.lock` line from the `.gitignore` if your project will be an end-user
   executable/application. See
   [the Rust FAQs for more information](https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-in-version-control-but-not-libraries).
2. Rename `src/main.rs` to `src/lib.rs` (and remove the `main` function) if your project is NOT an
   end-user executable/application (i.e. it is a library).
3. Update the `Cargo.toml` file based on your project.
4. Update the `CODEOWNERS` file based on your project.
5. Update this `README.md` file based on your project.

## Overview

This is a template repository. This template comes with support for the following:

* Support for all the items below on both Windows and Linux
* Unit testing
* Linting via [rust-clippy](https://github.com/rust-lang/rust-clippy)
* Formatting via [rustfmt](https://github.com/rust-lang/rustfmt)
* Code coverage analysis and "pretty" coverage reporting via [cargo-llvm-cov](https://github.com/taiki-e/cargo-llvm-cov)
* Execution analysis of Undefined Behavior via [Miri](https://github.com/rust-lang/miri)
* Orchestration of *all the above* via [cargo-make](https://github.com/sagiegurari/cargo-make)
(see [CONTRIBUTING.md](CONTRIBUTING.md) for details)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for developer-oriented information.
