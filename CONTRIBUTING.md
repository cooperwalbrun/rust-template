# Contributing to YOUR PROJECT NAME HERE

1. [Development Workspace Setup](#development-workspace-setup)
2. [Commands](#commands)
3. [Formatting and Linting Code](#formatting-and-linting-code)
4. [Code Policy](#code-policy)

## Development Workspace Setup

The main facility used for interacting with this project's lifecycle (build/test/format/lint) is
[cargo-make](https://sagiegurari.github.io/cargo-make). Therefore, this is the only dependency you
need to install on your machine:

```bash
cargo install cargo-make
```

## Commands

With `cargo-make`, all of this project's commands will become available to you:

```bash
cargo make clean            # Clean up temporary files
cargo make build            # Lint and build the project
cargo make run              # Run the application
cargo make test             # Run all unit tests
cargo make test-coverage    # Run all unit tests and write a code coverage report to STDOUT
cargo make test-coverage-ci # Run all unit tests and write a code coverage report to a text file in LCOV format
cargo make format           # Formats (rewrites) every applicable file in the project
cargo make format-ci        # Formats (report only) every applicable file in the project
cargo make lint             # Lints (report only) every applicable file in the project
cargo make lint-watch       # Lints (report only) every applicable file in the project and re-lints whenever files change
```

`cargo-make` will automatically fetch crates and toolchain components as needed when you run these
commands. Between this and what is defined in `Cargo.toml`, you should never need to issue a
`cargo install` command unless you are installing new dependencies.

## Formatting and Linting Code

This project uses [rustfmt](https://github.com/rust-lang/rustfmt) to handle formatting, and
contributions to its code are expected to be formatted with `rustfmt` (within reason) using the
settings in [rustfmt.toml](rustfmt.toml).

This project uses [rust-clippy](https://github.com/rust-lang/rust-clippy) to handle linting, and
contributions are expected to be checked using the settings in [clippy.toml](clippy.toml).

>Note: `rustfmt` and `rust-clippy` each have many built-in defaults that will be deferred to in the
>absence of a corresponding rule in `rustfmt.toml`/`clippy.toml`.

## Code Policy

Code contributed to this project should follow the
[Rust API Guidelines](https://rust-lang.github.io/api-guidelines/checklist.html) as much as
possible (even if this project is an application rather than a library).
