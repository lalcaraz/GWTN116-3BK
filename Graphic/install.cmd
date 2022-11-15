@echo off
cd /d %~dp0
pnputil /add-driver "Graphics\iigd_dch.inf" /install
exit 0