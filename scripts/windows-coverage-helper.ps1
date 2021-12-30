# This file is a Windows-friendly coverage solution based on the proposed approach documented here:
# https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/instrument-coverage.html

$html_output_directory = "./coverage/"
$profile_data_file = "./coverage.profdata"
$coverage_ignore_regex = '\.cargo.registry|\.rustup' # Matches .cargo/registry and .rustup/

# Generate log messages via Cargo that we can parse to extract the executables' paths
# Note that this command will not actually run any tests
# Also note that we specify the same environment variables/RUSTFLAGS/etc here as we do in the "test"
# workflow in Makefile.toml (this ensures that the binaries do not need to be recompiled between
# testing and code coverage analysis, i.e. the "cargo test" command below)
$Env:RUSTFLAGS = "-Zinstrument-coverage"
$json = cargo test --tests --no-run --message-format=json | ConvertFrom-Json

# Extract the names of the executable(s) that we instrumented for code coverage analysis
$test_json = $json | Where-Object { $_.profile.test -eq $TRUE }
$executables = $test_json | ForEach-Object { "`"$($_.executable)`"" }
$executables = $executables -Join " -object "

# Finally, run the command to create the coverage reports (calls llvm-cov's "report" command
# internally: llvm-cov report)
cargo cov -- report `
  $executables `
  -instr-profile "$profile_data_file" `
  -ignore-filename-regex "$coverage_ignore_regex"

# Additionally, we will create the HTML-based mini-site with in-depth coverage information
cargo cov -- show `
  -Xdemangler=rustfilt `
  $executables `
  -instr-profile "$profile_data_file" `
  -ignore-filename-regex "$coverage_ignore_regex" `
  -show-line-counts-or-regions `
  -format html `
  -output-dir "$html_output_directory"
