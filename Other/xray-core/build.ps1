Push-Location (Split-Path $MyInvocation.MyCommand.Path -Parent)

git clone https://github.com/xtls/xray-core -b 'v1.4.3' src
if ( -Not $? ) {
    Pop-Location
    exit $lastExitCode
}

$Env:CGO_ENABLED='0'
$Env:GOROOT_FINAL='/usr'

$Env:GOOS='windows'
$Env:GOARCH='amd64'
go build -a -trimpath -asmflags '-s -w' -ldflags '-s -w -buildid=' -o '..\release\xray.exe' '.\src\main'

Pop-Location
exit $lastExitCode