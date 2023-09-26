
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5Kirigami2Config.cmake.in                            ########

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

include(CMakeFindDependencyMacro)
find_dependency(Qt5Core 5.15.2)

# Any changes in this ".cmake" file will be overwritten by CMake, the source is the ".cmake.in" file.

include("${CMAKE_CURRENT_LIST_DIR}/KF5Kirigami2Targets.cmake")

set(Kirigami2_INSTALL_PREFIX "${PACKAGE_PREFIX_DIR}")

#set(Kirigami2_LIBRARIES KF5::Kirigami2)

include("${CMAKE_CURRENT_LIST_DIR}/KF5Kirigami2Macros.cmake")

