#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Phonon::phonon4qt5experimental" for configuration "RelWithDebInfo"
set_property(TARGET Phonon::phonon4qt5experimental APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Phonon::phonon4qt5experimental PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libphonon4qt5experimental.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libphonon4qt5experimental.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS Phonon::phonon4qt5experimental )
list(APPEND _IMPORT_CHECK_FILES_FOR_Phonon::phonon4qt5experimental "${_IMPORT_PREFIX}/lib/libphonon4qt5experimental.dll.a" "${_IMPORT_PREFIX}/bin/libphonon4qt5experimental.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
