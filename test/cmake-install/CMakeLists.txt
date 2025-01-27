# Configure install script
if (WIN32)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/test.bat
        ${CMAKE_CURRENT_BINARY_DIR}/test.bat COPYONLY)

    set(PIPE_IN_TEST_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/../test-pipe-in.bat)
    set(TEST_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/test.bat)
else ()
    configure_file(test.sh.in 
        ${CMAKE_CURRENT_BINARY_DIR}/test.sh @ONLY)

    set(PIPE_IN_TEST_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/../test-pipe-in.sh)
    set(TEST_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/test.sh)
endif ()

get_filename_component(TEST_NAME
   ${CMAKE_CURRENT_SOURCE_DIR}
   NAME)


# this build test only works, if nlohmann-json was found via a cmake-package
if(TARGET nlohmann_json::nlohmann_json)
    add_test(NAME Build::${TEST_NAME}
             COMMAND ${TEST_SCRIPT}
             WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
endif()
