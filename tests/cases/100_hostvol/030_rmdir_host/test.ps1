# SUMMARY: Remove a subdir create on the host in a container
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$dirName = "foobar"
$dirPath = Join-Path -Path $env:TEST_TMP -ChildPath $dirName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $dirPath

docker container run --platform linux --rm -v  $env:TEST_TMP`:/test alpine:3.7 sh -c "rmdir /test/$dirName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $dirPath) {
    $ret = 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
