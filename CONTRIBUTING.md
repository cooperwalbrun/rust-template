# Contributing to YOUR PROJECT NAME HERE

1. [Development Workspace Setup](#development-workspace-setup)
3. [Commands](#commands)
4. [Formatting and Linting Code](#formatting-and-linting-code)

## Development Workspace Setup

This project currently depends on the Rust `nightly` toolchain in order to access the latest
features of dependencies (such as `rustfmt`) and the Rust compiler (such as
[source-based-code-coverage](https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/source-based-code-coverage.html)).

The main facility used for interacting with this project's lifecycle (build/test/format/lint) is
[cargo-make](https://sagiegurari.github.io/cargo-make/). Therefore, this is the only dependency you
need to install on your machine:

```bash
cargo install cargo-make
```

If you are using a Linux-based machine, you will also need to install
[jq](https://stedolan.github.io/jq/download/) in order to run the code coverage command(s) mentioned
below.

## Commands

With `cargo-make`, all of this project's commands will become available to you:

```properties
cargo make clean         # Clean up temporary files
cargo make build         # Lint and build the project
cargo make test          # Run all unit tests
cargo make test-coverage # Run all unit tests and write a code coverage report to STDOUT
cargo make format        # Run rustfmt on every applicable file in the project
cargo make lint          # Run rust-clippy on every applicable file in the project
cargo make lint-watch    # Same as above, except execute indefinitely as a watcher (re-lint whenever files change)
```

>Note: the `test-coverage` command will also produce an in-depth HTML-based report which can be
>viewed by opening the `/coverage/index.html` file in a browser.

`cargo-make` will automatically fetch crates and toolchain components when needed as you run these
commands. Between this and what is defined in `Cargo.toml`, you should never need to issue a
`cargo install` command unless you are installing new dependencies.

Be aware that the `cargo make` commands above will use the `development` profile by default (i.e.
the build will not be production-optimized).

## Formatting and Linting Code

This project uses [rustfmt](https://github.com/rust-lang/rustfmt) to handle formatting, and
contributions to its code are expected to be formatted with `rustfmt` (within reason) using the
settings in [rustfmt.toml](rustfmt.toml). This can be automated in many popular IDEs and editors.

This project uses [rust-clippy](https://github.com/rust-lang/rust-clippy) to handle linting, and
contributions are expected to be checked using the settings in [clippy.toml](clippy.toml).

>Note: `rustfmt` and `rust-clippy` each have many built-in defaults that will be deferred to in the
>absence of a corresponding rule in `rustfmt.toml`/`clippy.toml`.
