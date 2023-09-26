
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5WindowSystemConfig.cmake.in                            ########

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
find_dependency(Qt5Gui 5.15.2)

if(NOT OFF)
    find_dependency(Qt5Widgets 5.15.2)
endif()

if()
    find_dependency(X11)
endif()

if(NOT ON)
    if(1)
        find_dependency(Qt5WinExtras 5.15.2)
    endif()

    if()
        if (NOT TARGET Qt6::Gui)
            find_dependency(Qt5X11Extras 5.15.2)
        else()
            # qtx11extras_p.h is in Qt6Gui, which is already a dependency
        endif()
        find_dependency(XCB)
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5WindowSystemTargets.cmake")

