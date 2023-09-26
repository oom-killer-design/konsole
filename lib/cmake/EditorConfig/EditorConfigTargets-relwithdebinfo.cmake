#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "editorconfig_static" for configuration "RelWithDebInfo"
set_property(TARGET editorconfig_static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(editorconfig_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libeditorconfig_static.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS editorconfig_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_editorconfig_static "${_IMPORT_PREFIX}/lib/libeditorconfig_static.a" )

# Import target "editorconfig_shared" for configuration "RelWithDebInfo"
set_property(TARGET editorconfig_shared APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(editorconfig_shared PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libeditorconfig.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libeditorconfig.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS editorconfig_shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_editorconfig_shared "${_IMPORT_PREFIX}/lib/libeditorconfig.dll.a" "${_IMPORT_PREFIX}/bin/libeditorconfig.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
