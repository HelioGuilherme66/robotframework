*** Settings ***
Suite Setup      Run Tests    ${EMPTY}    variables/variable_recommendations.robot
Force Tags       regression    pybot    jybot
Resource         atest_resource.robot

*** Test Cases ***
Simple Typo
    Check Test Case    ${TESTNAME} Scalar
    Check Test Case    ${TESTNAME} List

Access Scalar In List With Typo
    Check Test Case    ${TESTNAME}

Long Garbage Variable
    Check Test Case    ${TESTNAME}

Many Similar Variables
    Check Test Case    ${TESTNAME}

Misspelled
    Check Test Case    ${TESTNAME} Lower Case
    Check Test Case    ${TESTNAME} Underscore
    Check Test Case    ${TESTNAME} Period
    Check Test Case    ${TESTNAME} Camel Case
    Check Test Case    ${TESTNAME} Whitespace

Misspelled List Accessed As Scalar
    Check Test Case    ${TESTNAME}

Misspelled Scalar Accessed As List
    Check Test Case    ${TESTNAME}

Misspelled Env Var
    Check Test Case    ${TESTNAME}

Misspelled Env Var With Internal Variables
    Check Test Case    ${TESTNAME}

Misspelled List Variable With Period
    Check Test Case    ${TESTNAME}

Misspelled Extended Variable Parent
    Check Test Case    ${TESTNAME}

Misspelled Extended Variable Child
    Check Test Case    ${TESTNAME}

Existing Non ASCII Variable Name
    Check Test Case    ${TESTNAME}

Non Existing Non ASCII Variable Name
    Check Test Case    ${TESTNAME}

Invalid Binary
    Check Test Case    ${TESTNAME}

Invalid Multiple Whitespace
    Check Test Case    ${TESTNAME}

Non Existing Env Var
    Check Test Case    ${TESTNAME}

Multiple Missing Variables
    Check Test Case    ${TESTNAME}

Empty Variable Name
    Check Test Case    ${TESTNAME}

Environment Variable With Misspelled Internal Variables
    Check Test Case    ${TESTNAME}
