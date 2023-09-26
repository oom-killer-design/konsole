#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Phonon::phonon4qt5" for configuration "RelWithDebInfo"
set_property(TARGET Phonon::phonon4qt5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Phonon::phonon4qt5 PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libphonon4qt5.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libphonon4qt5.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS Phonon::phonon4qt5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_Phonon::phonon4qt5 "${_IMPORT_PREFIX}/lib/libphonon4qt5.dll.a" "${_IMPORT_PREFIX}/bin/libphonon4qt5.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
