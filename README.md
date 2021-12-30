# YOUR PROJECT NAME HERE ![master](https://github.com/cooperwalbrun/rust-template/workflows/master/badge.svg)

1. [Overview](#overview)
2. [Contributing](#contributing)

## Overview

This is a template repository. This template comes with support for the following:

* Support for all the items below on both Windows and Linux
* Unit testing
* Linting via [rust-clippy](https://github.com/rust-lang/rust-clippy)
* Formatting via [rustfmt](https://github.com/rust-lang/rustfmt)
* Code coverage and "pretty" code coverage reporting via
[a clever combination](https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/instrument-coverage.html#test-coverage) of the following:
  * [rustfilt](https://github.com/luser/rustfilt)
  * [llvm-tools-preview](https://rust-lang.github.io/rustup/concepts/components.html)
  * [llvm-profdata](https://llvm.org/docs/CommandGuide/llvm-profdata.html)
  * [llvm-cov](https://llvm.org/docs/CommandGuide/llvm-cov.html)
  * [cargo-bintools](https://github.com/rust-embedded/cargo-binutils)
* Execution analysis of Undefined Behavior via [Miri](https://github.com/rust-lang/miri)
* Facilitation/orchestration of *all the above* via [cargo-make](https://github.com/sagiegurari/cargo-make)
(see [CONTRIBUTING.md](CONTRIBUTING.md) for details)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for developer-oriented information.
