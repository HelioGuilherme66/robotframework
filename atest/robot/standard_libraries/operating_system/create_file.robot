*** Settings ***
Suite Setup      Run Tests    ${EMPTY}    standard_libraries/operating_system/create_file.robot
Force Tags       regression    pybot    jybot
Resource         atest_resource.robot

*** Test Cases ***
Create File With Default Content
    Check Test Case    ${TESTNAME}

Create File With Content
    Check Test Case    ${TESTNAME}

Create Non-ASCII File With Default Encoding
    Check Test Case    ${TESTNAME}

Create File With Encoding
    Check Test Case    ${TESTNAME}

Create File With Non-ASCII Name
    Check Test Case    ${TESTNAME}

Create File With Space In Name
    Check Test Case    ${TESTNAME}

Create File To Non-Existing Directory
    Check Test Case    ${TESTNAME}

Creating File Fails If Encoding Is Incorrect
    Check Test Case    ${TESTNAME}

Create Binary File Using Bytes
    Check Test Case    ${TESTNAME}

Create Binary File Using Unicode
    Check Test Case    ${TESTNAME}

Creating Binary File Using Unicode With Ordinal > 255 Fails
    Check Test Case    ${TESTNAME}

Append To File
    Check Test Case    ${TESTNAME}
