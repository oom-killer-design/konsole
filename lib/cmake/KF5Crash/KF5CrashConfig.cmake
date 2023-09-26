
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5CrashConfig.cmake.in                            ########

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

# Any changes in this file will be overwritten by CMake.

include(CMakeFindDependencyMacro)
find_dependency(Qt5Core 5.15.2)

if (NOT ON)
    find_dependency(Qt5Gui 5.15.2)
    find_dependency(KF5CoreAddons REQUIRED)

    if (OFF)
        if (TARGET Qt5::Core)
            find_dependency(Qt5X11Extras REQUIRED)
        endif()
        find_dependency(X11 REQUIRED)
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5CrashTargets.cmake")

