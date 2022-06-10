#!/bin/bash

# This file is a Linux-friendly coverage solution based on the proposed approach documented here:
# https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/instrument-coverage.html

HTML_OUTPUT_DIRECTORY="./coverage/"
PROFILE_DATA_FILE="./coverage.profdata"
COVERAGE_IGNORE_REGEX='\.cargo.registry|\.rustup' # Matches .cargo/registry and .rustup/

# Generate log messages via Cargo and then parse them to extract the instrumented executables' paths
# Note that this command will not actually run any tests
ARTIFACTS=$( \
  RUSTFLAGS="-Cinstrument-coverage" \
  cargo test --tests --no-run --message-format=json \
    | jq -r "select(.profile.test == true) | .filenames[]" \
    | grep -v dSYM - \
)
EXECUTABLES=""
for ARTIFACT in $ARTIFACTS; do
  # We trim the artifact in order to deal with spaces that appear in the filenames (due to jq?)
  SANITIZED_ARTIFACT=${ARTIFACT//[$'\t\r\n']}
  if [[ -x "$SANITIZED_ARTIFACT" ]]; then # Only include executable artifacts
    EXECUTABLES="$EXECUTABLES -object $SANITIZED_ARTIFACT"
  fi
done
# Below strips off the leading " -object " because llvm-cov expects the first file to NOT be
# specified with -object
EXECUTABLES=${EXECUTABLES:8}

# Finally, run the command to create the coverage reports (calls llvm-cov's "report" command
# internally: llvm-cov report)
cargo cov -- report \
  -ignore-filename-regex "$COVERAGE_IGNORE_REGEX" \
  -instr-profile "$PROFILE_DATA_FILE" \
  $EXECUTABLES

# Additionally, we will create the HTML-based mini-site with in-depth coverage information
cargo cov -- show \
  -Xdemangler=rustfilt \
  -ignore-filename-regex "$COVERAGE_IGNORE_REGEX" \
  -show-line-counts-or-regions \
  -format html \
  -output-dir "$HTML_OUTPUT_DIRECTORY" \
  -instr-profile "$PROFILE_DATA_FILE" \
  $EXECUTABLES
