#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "dbus-1" for configuration "RelWithDebInfo"
set_property(TARGET dbus-1 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-1 PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libdbus-1.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libdbus-1-3.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-1 )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-1 "${_IMPORT_PREFIX}/lib/libdbus-1.dll.a" "${_IMPORT_PREFIX}/bin/libdbus-1-3.dll" )

# Import target "dbus-daemon" for configuration "RelWithDebInfo"
set_property(TARGET dbus-daemon APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-daemon PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-daemon.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-daemon )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-daemon "${_IMPORT_PREFIX}/bin/dbus-daemon.exe" )

# Import target "dbus-send" for configuration "RelWithDebInfo"
set_property(TARGET dbus-send APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-send PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-send.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-send )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-send "${_IMPORT_PREFIX}/bin/dbus-send.exe" )

# Import target "dbus-test-tool" for configuration "RelWithDebInfo"
set_property(TARGET dbus-test-tool APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-test-tool PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-test-tool.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-test-tool )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-test-tool "${_IMPORT_PREFIX}/bin/dbus-test-tool.exe" )

# Import target "dbus-update-activation-environment" for configuration "RelWithDebInfo"
set_property(TARGET dbus-update-activation-environment APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-update-activation-environment PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-update-activation-environment.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-update-activation-environment )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-update-activation-environment "${_IMPORT_PREFIX}/bin/dbus-update-activation-environment.exe" )

# Import target "dbus-launch" for configuration "RelWithDebInfo"
set_property(TARGET dbus-launch APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-launch PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-launch.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-launch )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-launch "${_IMPORT_PREFIX}/bin/dbus-launch.exe" )

# Import target "dbus-monitor" for configuration "RelWithDebInfo"
set_property(TARGET dbus-monitor APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-monitor PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-monitor.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-monitor )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-monitor "${_IMPORT_PREFIX}/bin/dbus-monitor.exe" )

# Import target "dbus-run-session" for configuration "RelWithDebInfo"
set_property(TARGET dbus-run-session APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dbus-run-session PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/dbus-run-session.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS dbus-run-session )
list(APPEND _IMPORT_CHECK_FILES_FOR_dbus-run-session "${_IMPORT_PREFIX}/bin/dbus-run-session.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
