*** Settings ***
Documentation  This is demo test suite
Library  Library/DemoLibrary.py
Library  String
#Suite Setup
#Suite Teardown

*** Variables ***
${RESPONSE_CODE_200} =  200
${RESPONSE_CODE_404} =  404
${HEADER_HEADER_NAME} =  Test-Header
${HEADER_HEADER_VALUE} =  3600
${RESPONSE_CODE_MSG} =  Респонс-код неверный
${HEADERS_DONT_MUTCH} =  Хидер неверный
${STRING_COUNT_DOESNT_MUTCH} =  Количество строк в респонсе неверное

*** Test Cases ***
Test Case Get Info
    [Documentation]  Test case for /get request
    ${response} =  Get Info  ${HEADER_HEADER_NAME}  ${HEADER_HEADER_VALUE}
    Log  ${response.text}
    ${headerValue} =  Get Header Value From Json  ${response}  ${HEADER_HEADER_NAME}
    Should Be Equal As Integers  ${headerValue}  ${HEADER_HEADER_VALUE}  ${HEADERS_DONT_MUTCH}
    Should Be Equal As Integers  ${response.status_code}  ${RESPONSE_CODE_200}  ${RESPONSE_CODE_MSG}

Test Case Stream
    [Documentation]  Test case for /stream/:n
    ${rnd_string_count} =  Get Rnd Value
    Log  ${rnd_string_count}
    ${response} =  Stream  ${rnd_string_count}
    Log  ${response.text}
    ${strings_count} =  Get Line Count  ${response.text}
    Should Be Equal As Integers  ${strings_count}  ${rnd_string_count}  ${STRING_COUNT_DOESNT_MUTCH}
    Should Be Equal As Strings  ${response.status_code}  ${RESPONSE_CODE_200}  ${RESPONSE_CODE_MSG}

Test Case Basic Authz Data Driven
    [Tags]  CurrentTest
    [Template]  Basic Authz
    #username         #password          #expected_response
    test_user          123456             ${RESPONSE_CODE_200}
    ${empty}           1234567            ${RESPONSE_CODE_404}
    test_user          ${empty}           ${RESPONSE_CODE_404}

*** Keywords ***
Basic Authz   [Arguments]  ${username}  ${password}  ${expected_response}
    ${response} =  Passwd  ${username}  ${password}
    Log  ${response.text}
    Should Be Equal As Integers  ${response.status_code}  ${expected_response}  ${RESPONSE_CODE_MSG}
