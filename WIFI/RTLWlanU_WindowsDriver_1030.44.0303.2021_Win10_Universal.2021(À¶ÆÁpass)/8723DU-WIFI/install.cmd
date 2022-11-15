@echo off
cd /d %~dp0
devcon rescan
pnputil /delete-driver oem31.inf /force /uninstall
devcon rescan
pnputil /add-driver "%~dp0Win10X64\*.inf" /install
devcon rescan
exit
