# SUMMARY: Verify that docker container run --privileged works
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$output = [string] (& docker container run --platform linux --rm --privileged alpine:3.7 id 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output
exit 0
