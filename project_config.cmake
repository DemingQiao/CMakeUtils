if(WIN32)
  message("Running on WINDOWS")
  add_compile_definitions(HARD_WINDOWS)
endif()

if(UNIX AND NOT APPLE)
  message("Running on unix")
  add_compile_definitions(HARD_UNIX)
endif()

if(APPLE)
  message("Running on Apple")
  add_compile_definitions(HARD_APPLE)
endif()

string(TOUPPER ${PROJECT_NAME} PROJECT_NAME_UPPERCASE)
string(TOLOWER ${PROJECT_NAME} PROJECT_NAME_LOWERCASE)

set(CMAKE_DEBUG_POSTFIX "d")
# project version config
configure_file("${CMAKE_SOURCE_DIR}/cmake/version.h.in"
               "${CMAKE_SOURCE_DIR}/include/version.h" @ONLY)

# project package config
set(CONFIG_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(GENERATED_DIR "${CMAKE_CURRENT_BINARY_DIR}/generated")
set(VERSION_CONFIG_FILE "${GENERATED_DIR}/${PROJECT_NAME}ConfigVersion.cmake")
set(PROJECT_CONFIG_FILE "${GENERATED_DIR}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
include(GenerateExportHeader)

write_basic_package_version_file(
  ${VERSION_CONFIG_FILE}
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

configure_package_config_file(
  ${CMAKE_SOURCE_DIR}/cmake/Config.cmake.in ${PROJECT_CONFIG_FILE}
  INSTALL_DESTINATION ${CONFIG_INSTALL_DIR})

install(FILES "${PROJECT_CONFIG_FILE}" "${VERSION_CONFIG_FILE}"
            DESTINATION "${CONFIG_INSTALL_DIR}")

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
