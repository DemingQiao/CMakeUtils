function(LIBRARY_INSTALL_CONFIG LIBRARY_NAME)
    aux_source_directory(${CMAKE_SOURCE_DIR}/src/${LIBRARY_NAME} SRC)
    add_library(${LIBRARY_NAME} SHARED ${SRC})
    target_compile_definitions(${LIBRARY_NAME} PRIVATE ${LIBRARY_NAME}_EXPORT)
    configure_file(${CMAKE_SOURCE_DIR}/cmake/export.h.in ${CMAKE_SOURCE_DIR}/include/${LIBRARY_NAME}/export.h @ONLY)
    add_library(${PROJECT_NAME}::${LIBRARY_NAME} ALIAS ${LIBRARY_NAME})

    target_compile_definitions(
            ${LIBRARY_NAME} PRIVATE ${PROJECT_NAME_UPPERCASE}_DEBUG=$<CONFIG:Debug>)
    target_include_directories(
            ${LIBRARY_NAME}
            PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
            $<BUILD_INTERFACE:${GENERATED_HEADERS_DIR}>
            $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
    install(
            TARGETS ${LIBRARY_NAME}
            EXPORT ${TARGETS_EXPORT_NAME}
            LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
            ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
            RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
            PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
            INCLUDES
            DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
    install(
            EXPORT ${TARGETS_EXPORT_NAME}
            DESTINATION ${CONFIG_INSTALL_DIR}
            NAMESPACE ${PROJECT_NAME}::)
endfunction()
