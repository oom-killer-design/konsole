
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5ConfigWidgetsConfig.cmake.in                            ########

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
if (FALSE)
  find_dependency(KF5Auth "5.110.0")
endif()
find_dependency(KF5Codecs "5.110.0")
find_dependency(KF5Config "5.110.0")
find_dependency(KF5WidgetsAddons "5.110.0")
find_dependency(KF5CoreAddons "5.110.0")

# Not using 'TARGET Qt6::Core5Compat' as it may be undefined at the
# time this file is used
if(FALSE)
    find_dependency(Qt6Core5Compat 5.15.2)
endif()

if (NOT ON)
    find_dependency(Qt5Widgets 5.15.2)

    if (NOT ANDROID)
        find_dependency(Qt5DBus 5.15.2)
    endif()

    find_dependency(KF5GuiAddons "5.110.0")
    find_dependency(KF5I18n "5.110.0")
endif()


include("${CMAKE_CURRENT_LIST_DIR}/KF5ConfigWidgetsTargets.cmake")

