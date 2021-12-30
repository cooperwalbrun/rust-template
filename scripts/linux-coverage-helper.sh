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
EXECUTABLES=$( \
  for path in $( \
    cargo test --tests --no-run --message-format=json \
      | jq -r "select(.profile.test == true) | .executable" \
      | grep -v dSYM - \
  ); do printf "\"%s\"" $path; done \
)

# Format the executable paths in a way that cooperates with llvm-cov
function join_by { local d=$1; shift; local f=$1; shift; printf "%s" "$f" "${@/#/$d}"; }
COMMAND_FRAGMENT=$(join_by " --object " $EXECUTABLES)

# Finally, run the command to create the coverage reports (calls llvm-cov's "report" command
# internally: llvm-cov report)
cargo cov -- report \
  "$COMMAND_FRAGMENT" \
  --instr-profile "$PROFILE_DATA_FILE" \
  --ignore-filename-regex "$COVERAGE_IGNORE_REGEX"

# Additionally, we will create the HTML-based mini-site with in-depth coverage information
cargo cov -- show \
  --Xdemangler=rustfilt \
  "$COMMAND_FRAGMENT" \
  --instr-profile "$PROFILE_DATA_FILE" \
  --ignore-filename-regex "$COVERAGE_IGNORE_REGEX" \
  --show-line-counts-or-regions \
  --format html \
  --output-dir "$HTML_OUTPUT_DIRECTORY"
