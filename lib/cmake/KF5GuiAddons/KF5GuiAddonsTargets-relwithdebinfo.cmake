#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::GuiAddons" for configuration "RelWithDebInfo"
set_property(TARGET KF5::GuiAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::GuiAddons PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5GuiAddons.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5GuiAddons.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::GuiAddons )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::GuiAddons "${_IMPORT_PREFIX}/lib/libKF5GuiAddons.dll.a" "${_IMPORT_PREFIX}/bin/libKF5GuiAddons.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
