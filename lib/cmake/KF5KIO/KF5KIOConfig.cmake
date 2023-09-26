
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5KIOConfig.cmake.in                            ########

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

# Any changes in this ".cmake" file will be overwritten by CMake, the source is the ".cmake.in" file.

set(KCookieServer_DBUS_INTERFACE "${PACKAGE_PREFIX_DIR}/bin/data/dbus-1/interfaces/kf5_org.kde.KCookieServer.xml")
set(KSlaveLauncher_DBUS_INTERFACE "${PACKAGE_PREFIX_DIR}/bin/data/dbus-1/interfaces/kf5_org.kde.KSlaveLauncher.xml")

include(CMakeFindDependencyMacro)
find_dependency(KF5CoreAddons "5.110.0")
find_dependency(KF5Config "5.110.0")
find_dependency(KF5Service "5.110.0")

if (NOT OFF)
    find_dependency(KF5Bookmarks "5.110.0")
    find_dependency(KF5Completion "5.110.0")
    find_dependency(KF5ItemViews "5.110.0")
    find_dependency(KF5JobWidgets "5.110.0")
    find_dependency(KF5Solid "5.110.0")
    find_dependency(KF5XmlGui "5.110.0")
    find_dependency(KF5WidgetsAddons "5.110.0")
    find_dependency(KF5WindowSystem "5.110.0")

    if (NOT ON)
        find_dependency(KF5ConfigWidgets "5.110.0")
        find_dependency(KF5GuiAddons "5.110.0")
        find_dependency(KF5IconThemes "5.110.0")

        if (NOT ANDROID)
            find_dependency(KF5DBusAddons "5.110.0")
            find_dependency(KF5Crash "5.110.0")
        endif()

        if ()
            find_dependency(LibMount)
        endif()
    endif()
endif()

find_dependency(Qt5Network "5.15.2")
if (NOT OFF)
find_dependency(Qt5Concurrent "5.15.2")
endif()
if (NOT ANDROID)
    find_dependency(Qt5DBus "5.15.2")
endif()

if()
    find_dependency(Qt6Core5Compat 5.15.2)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5KIOTargets.cmake")

