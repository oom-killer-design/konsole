#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "png_shared" for configuration "RelWithDebInfo"
set_property(TARGET png_shared APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(png_shared PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libpng16.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libpng16.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS png_shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_png_shared "${_IMPORT_PREFIX}/lib/libpng16.dll.a" "${_IMPORT_PREFIX}/bin/libpng16.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
