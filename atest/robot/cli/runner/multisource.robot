*** Settings ***
Documentation   Running multiple suites together.
Force Tags      regression  pybot  jybot
Resource        cli_resource.robot

*** Test Cases ***

Default Name
    Run Tests  ${EMPTY}  core/misc/some_tests.html  core/misc/example_tests.html
    Check Names  ${SUITE}  Some Tests & Example Tests
    Should Contain Suites   ${SUITE}  Some Tests   Example Tests
    Check Names  ${SUITE.suites[0]}  Some Tests  Some Tests & Example Tests.
    Should Contain Tests  ${SUITE.suites[0]}  Some Test 1  Some Test 2
    Check Names  ${SUITE.suites[0].tests[0]}  Some Test 1  Some Tests & Example Tests.Some Tests.
    Check Names  ${SUITE.suites[0].tests[1]}  Some Test 2  Some Tests & Example Tests.Some Tests.
    Check Names  ${SUITE.suites[1]}  Example Tests  Some Tests & Example Tests.
    Should Contain Tests  ${SUITE.suites[1]}  Example Test 1   Example Test 2
    Check Names  ${SUITE.suites[1].tests[0]}  Example Test 1  Some Tests & Example Tests.Example Tests.
    Check Names  ${SUITE.suites[1].tests[1]}  Example Test 2  Some Tests & Example Tests.Example Tests.

Overridden Name
    Run Tests  --name My_Name  core/misc/some_tests.html  core/misc/example_tests.html
    Check Names  ${SUITE}  My Name
    Should Contain Suites  ${SUITE}  Some Tests   Example Tests
    Check Names  ${SUITE.suites[0]}  Some Tests  My Name.
    Should Contain Tests  ${SUITE.suites[0]}  Some Test 1   Some Test 2
    Check Names  ${SUITE.suites[0].tests[0]}  Some Test 1  My Name.Some Tests.
    Check Names  ${SUITE.suites[0].tests[1]}  Some Test 2  My Name.Some Tests.
    Check Names  ${SUITE.suites[1]}  Example Tests  My Name.
    Should Contain Tests  ${SUITE.suites[1]}  Example Test 1   Example Test 2
    Check Names  ${SUITE.suites[1].tests[0]}  Example Test 1  My Name.Example Tests.
    Check Names  ${SUITE.suites[1].tests[1]}  Example Test 2  My Name.Example Tests.

Wildcards
    Run Tests  ${EMPTY}  misc/suites/tsuite?.*ml
    Check Names  ${SUITE}  Tsuite1 & Tsuite2 & Tsuite3
    Should Contain Suites  ${SUITE}  Tsuite1   Tsuite2   Tsuite3
    Check Names  ${SUITE.suites[0]}  Tsuite1  Tsuite1 & Tsuite2 & Tsuite3.
    Should Contain Tests  ${SUITE.suites[0]}  Suite1 First   Suite1 Second   Third In Suite1
    Check Names  ${SUITE.suites[0].tests[0]}  Suite1 First  Tsuite1 & Tsuite2 & Tsuite3.Tsuite1.
    Check Names  ${SUITE.suites[0].tests[1]}  Suite1 Second  Tsuite1 & Tsuite2 & Tsuite3.Tsuite1.
    Check Names  ${SUITE.suites[0].tests[2]}  Third In Suite1  Tsuite1 & Tsuite2 & Tsuite3.Tsuite1.
    Check Names  ${SUITE.suites[1]}  Tsuite2  Tsuite1 & Tsuite2 & Tsuite3.
    Should Contain Tests  ${SUITE.suites[1]}  Suite2 First
    Check Names  ${SUITE.suites[1].tests[0]}  Suite2 First  Tsuite1 & Tsuite2 & Tsuite3.Tsuite2.
    Check Names  ${SUITE.suites[2]}  Tsuite3  Tsuite1 & Tsuite2 & Tsuite3.
    Should Contain Tests  ${SUITE.suites[2]}   Suite3 First
    Check Names  ${SUITE.suites[2].tests[0]}  Suite3 First  Tsuite1 & Tsuite2 & Tsuite3.Tsuite3.

Failure When Parsing Any Data Source Fails
    Run Tests Without Processing Output    ${EMPTY}    nönex    misc/pass_and_fail.robot
    ${nönex} =    Normalize Path    ${DATADIR}/nönex
    Check Stderr Contains  [ ERROR ] Parsing '${nönex}' failed: Data source does not exist.
    File Should Not Exist    ${OUTDIR}${/}output.xml

Warnings And Error When Parsing All Data Sources Fail
    Run Tests Without Processing Output  ${EMPTY}  nönex1  nönex2
    ${nönex} =  Normalize Path  ${DATADIR}/nönex
    Check Stderr Contains  [ ERROR ] Parsing '${nönex}1' failed: Data source does not exist.
