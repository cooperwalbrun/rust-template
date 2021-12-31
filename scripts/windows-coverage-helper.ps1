# This file is a Windows-friendly coverage solution based on the proposed approach documented here:
# https://doc.rust-lang.org/nightly/unstable-book/compiler-flags/instrument-coverage.html

$html_output_directory = "./coverage/"
$profile_data_file = "./coverage.profdata"
$coverage_ignore_regex = '\.cargo.registry|\.rustup' # Matches .cargo/registry and .rustup/

# Generate log messages via Cargo that we can parse to extract the executables' paths
# Note that this command will not actually run any tests
$Env:RUSTFLAGS = "-Zinstrument-coverage"
$json = cargo test --tests --no-run --message-format=json | ConvertFrom-Json

# Extract the names of the executable(s) that we instrumented for code coverage analysis
$artifacts = $json | Where-Object { $_.profile.test -eq $TRUE }
$coverage_analyzed_artifacts=@()
ForEach ($artifact in $artifacts) {
  ForEach ($filename in $artifact.filenames) {
    if ([IO.Path]::GetExtension($filename) -eq ".exe") { # Only include executable artifacts
      $coverage_analyzed_artifacts += "$filename"
    }
  }
}
$coverage_analyzed_artifacts = $coverage_analyzed_artifacts -Join " -object "

# Finally, run the command to create the coverage reports (calls llvm-cov's "report" command
# internally: llvm-cov report)
cargo cov -- report `
  -ignore-filename-regex "$coverage_ignore_regex" `
  -instr-profile "$profile_data_file" `
  $coverage_analyzed_artifacts

# Additionally, we will create the HTML-based mini-site with in-depth coverage information
cargo cov -- show `
  -Xdemangler=rustfilt `
  -ignore-filename-regex "$coverage_ignore_regex" `
  -show-line-counts-or-regions `
  -format html `
  -output-dir "$html_output_directory" `
  -instr-profile "$profile_data_file" `
  $coverage_analyzed_artifacts
