#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "harfbuzz::harfbuzz" for configuration "RelWithDebInfo"
set_property(TARGET harfbuzz::harfbuzz APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(harfbuzz::harfbuzz PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libharfbuzz.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libharfbuzz.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS harfbuzz::harfbuzz )
list(APPEND _IMPORT_CHECK_FILES_FOR_harfbuzz::harfbuzz "${_IMPORT_PREFIX}/lib/libharfbuzz.dll.a" "${_IMPORT_PREFIX}/bin/libharfbuzz.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
