:: environment setting for dbus clients
@echo off

:: session bus address
set DBUS_SESSION_BUS_ADDRESS=autolaunch:scope=*install-path

:: system bus address
set DBUS_SYSTEM_BUS_DEFAULT_ADDRESS=autolaunch:scope=*install-path
