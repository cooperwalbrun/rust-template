#!/bin/bash

# This file is a Linux-friendly coverage solution based on the proposed approach documented here:
# https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/instrument-coverage.html

HTML_OUTPUT_DIRECTORY="./coverage/"
PROFILE_DATA_FILE="./coverage.profdata"
COVERAGE_IGNORE_REGEX='\.cargo.registry|\.rustup' # Matches .cargo/registry and .rustup/

if ! [ -x "$(command -v jq)" ]; then
  echo "jq is not installed. Please install it in order to proceed (see https://stedolan.github.io/jq/download/)."
  exit 1
fi

# Generate log messages via Cargo and then parse them to extract the instrumented executables' paths
# Note that this command will not actually run any tests
# Also note that we specify the same environment variables/RUSTFLAGS/etc here as we do in the "test"
# workflow in Makefile.toml (this ensures that the binaries do not need to be recompiled between
# testing and code coverage analysis, i.e. the "cargo test" command below)
EXECUTABLES=$( \
  for path in $( \
    RUSTFLAGS="-Zinstrument-coverage" \
    cargo test --tests --no-run --message-format=json \
      | jq -r "select(.profile.test == true) | .executable" \
      | grep -v dSYM - \
  ); do printf "%s \"%s\" " "-object" "$path"; done \
)
# Below strips off the leading "-object " because llvm-cov expects the first file to NOT be
# specified with -object
EXECUTABLES=${EXECUTABLES:8}

# Finally, run the command to create the coverage reports (calls llvm-cov's "report" command
# internally: llvm-cov report)
cargo cov -- report \
  $EXECUTABLES \
  -instr-profile "$PROFILE_DATA_FILE" \
  -ignore-filename-regex "$COVERAGE_IGNORE_REGEX"

# Additionally, we will create the HTML-based mini-site with in-depth coverage information
cargo cov -- show \
  -Xdemangler=rustfilt \
  $EXECUTABLES \
  -instr-profile "$PROFILE_DATA_FILE" \
  -ignore-filename-regex "$COVERAGE_IGNORE_REGEX" \
  -show-line-counts-or-regions \
  -format html \
  -output-dir "$HTML_OUTPUT_DIRECTORY"
