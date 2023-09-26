# config file for phonon library


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was PhononConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

# known at buildtime
set(PHONON_LIB_SONAME "phonon4qt5")
set(PHONON_VERSION 4.11.1)

set(PHONON_PULSESUPPORT FALSE)
set(PHONON_FIND_EXPERIMENTAL ON)
set(PHONON_BACKEND_DIR_SUFFIX phonon4qt5_backend)

# install locations
set(PHONON_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include/phonon4qt5")
set(PHONON_LIBRARY_DIR "${PACKAGE_PREFIX_DIR}/lib")
#   this technically depends on ECM. since this is only useful to backends we
#   we'll not want to drag ECM in automatically though.
set(PHONON_BACKEND_DIR "${KDE_INSTALL_QTPLUGINDIR}/${PHONON_BACKEND_DIR_SUFFIX}")
#   Do not use! Only here for trivial compatibility with old backends.
set(PHONON_BUILDSYSTEM_DIR "${PACKAGE_PREFIX_DIR}/bin/data/phonon4qt5/buildsystem/")

# dependencies
include(CMakeFindDependencyMacro)
find_dependency(Qt5Core)
find_dependency(Qt5Widgets)

include("${CMAKE_CURRENT_LIST_DIR}/PhononTargets.cmake")
set(PHONON_LIBRARY Phonon::phonon4qt5)

# Find Experimental.
# Iff it was specified as component we require it.
# Else if we built with it we try to find it quietly.
# The latter part is to provide backwards compatibility as a simple finding of
# Phonon would also drag in experimental. To simulate this we'll look for it
# silenetly while not failing if it was not found. Ultimately it was the
# config consumer's responsibility to check if experimental was actually found.
# So nothing changes there. Config consumers can however now use it as a
# component to force an error when it isn't available.
if("${Phonon4Qt5_FIND_COMPONENTS}" MATCHES ".*(Experimental|experimental).*")
    find_package(Phonon4Qt5Experimental ${PHONON_VERSION} EXACT CONFIG REQUIRED
                 PATHS ${CMAKE_CURRENT_LIST_DIR}
                 NO_DEFAULT_PATH)
elseif(PHONON_FIND_EXPERIMENTAL)
    find_package(Phonon4Qt5Experimental ${PHONON_VERSION} EXACT CONFIG QUIET
                 PATHS ${CMAKE_CURRENT_LIST_DIR}
                 NO_DEFAULT_PATH)
endif()

# Convenience.
set(PHONON_LIBRARIES ${PHONON_LIBRARY} ${PHONON_EXPERIMENTAL_LIBRARY})
# The following one is only for compatiblity
set(PHONON_LIBS ${PHONON_LIBRARIES})
set(PHONON_INCLUDES ${PHONON_INCLUDE_DIR} ${PHONON_INCLUDE_DIR}/KDE)
