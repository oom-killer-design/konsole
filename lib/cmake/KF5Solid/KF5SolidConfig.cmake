# SolidConfig.cmake provides information about the installed Solid library.
# It can be used directly from CMake via find_package(Solid NO_MODULE)
#
# The following CMake variables are provided:
#   Solid_VERSION_MAJOR - the major version number of Solid
#   Solid_VERSION_MINOR - the minor version number of Solid
#   Solid_VERSION_PATCH - the patch version number of Solid
#   Solid_INCLUDE_DIRS  - the include directories to use
#   Solid_HAVE_UDev         - TRUE if device discovery via udev is supported
#
# Additionally, the following imported library targets are created, which may be used directly
# with target_link_libraries():
#   KF5::Solid - the Solid library


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5SolidConfig.cmake.in                            ########

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

set(SOLID_DBUS_INTERFACES_DIR "${PACKAGE_PREFIX_DIR}/bin/data/dbus-1/interfaces")

include(CMakeFindDependencyMacro)
find_dependency(Qt5Core 5.15.2)

if (NOT ON)
    find_dependency(Qt5Xml 5.15.2)
    find_dependency(Qt5Gui 5.15.2)

    if ("" OR "")
        find_dependency(Qt5DBus 5.15.2)
    endif()

    if ()
        find_dependency(LibMount)
    endif()

    if ()
        find_dependency(UDev)
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5SolidTargets.cmake")


# "public" variables:


set(Solid_HAVE_UDev  )

