#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::kcmdesktopfilegenerator" for configuration "RelWithDebInfo"
set_property(TARGET KF5::kcmdesktopfilegenerator APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::kcmdesktopfilegenerator PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/kcmdesktopfilegenerator.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::kcmdesktopfilegenerator )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::kcmdesktopfilegenerator "${_IMPORT_PREFIX}/bin/kcmdesktopfilegenerator.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
