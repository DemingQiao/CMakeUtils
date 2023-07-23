function(COPY_RUNTIME_DEPS TARGET)
    add_custom_command(TARGET ${TARGET} POST_BUILD 
            COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:${TARGET}> $<TARGET_FILE_DIR:${TARGET}>
            COMMAND_EXPAND_LISTS
            )
endfunction()
