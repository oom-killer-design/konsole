# config file for phonon experimental library
# This config can not be used directly. Instead find Phonon or Phonon4Qt5.
# If the experimental config is present it will be automatically included.
# If you want to make sure it is present you can specify Experimental as a
# COMPONENT in find_package.


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was PhononExperimentalConfig.cmake.in                            ########

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

include("${CMAKE_CURRENT_LIST_DIR}/PhononExperimentalTargets.cmake")
set(PHONON_EXPERIMENTAL_LIBRARY Phonon::phonon4qt5experimental)
set(PHONON_FOUND_EXPERIMENTAL true)

# Make sure phonon itself was imported. Experimental strictly depends on Phonon!
if(NOT TARGET Phonon::phonon4qt5)
    message(FATAL_ERROR "PhononExperimental library was found but there is no target for the primary library.")
endif()
