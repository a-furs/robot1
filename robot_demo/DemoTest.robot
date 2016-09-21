*** Settings ***
Documentation  Проверка demo REST сервиса http://httpbin.org/
Resource  ./Resources/Common.robot

*** Test Cases ***
Test Case Get
    [Documentation]  Test case for /get request
    Set Test Variable  ${header_name}  Header-Name
    Set Test Variable  ${header_value}  test_header_value
    ${response} =  Get Request  ${HTTPBIN_HOST}  ${header_name}  ${header_value}
    Dictionary Should Contain Item  ${response.json()['headers']}  ${header_name}  ${header_value}
    RequestsChecker.Common Check  ${response}

Test Case Stream
    [Documentation]  Test case for /stream/:n
    ${response} =  Stream Request  ${HTTPBIN_HOST}  ${NUMBER_OF_LINES}
    ${strings_count} =  Get Line Count  ${response.text}
    Should Be Equal As Integers  ${strings_count}  ${NUMBER_OF_LINES}  Количество строк в респонсе неверное
    RequestsChecker.Common Check  ${response}

Test Case Basic Authz Data Driven
    [Tags]  CurrentTest
    [Template]  Basic Authz
    #usernameURL               #passwordURL            sernameBasicAuth             #passwordBasicAuth           #expected_response
    ${HTTPBIN_AUTH_USERNAME}   ${HTTPBIN_AUTH_PASSWD}  ${HTTPBIN_AUTH_USERNAME}     ${HTTPBIN_AUTH_PASSWD}       ${HTTP_RESPONSE_CODE_OK}
    ${HTTPBIN_AUTH_USERNAME}   ${HTTPBIN_AUTH_PASSWD}  ${INVALID_VALUE}             ${HTTPBIN_AUTH_PASSWD}       ${HTTP_RESPONSE_CODE_UNAOUTHORIZED}
    ${HTTPBIN_AUTH_USERNAME}   ${HTTPBIN_AUTH_PASSWD}  ${HTTPBIN_AUTH_USERNAME}     ${INVALID_VALUE}             ${HTTP_RESPONSE_CODE_UNAOUTHORIZED}

*** Keywords ***
Basic Authz   [Arguments]  ${usernameURL}  ${passwordURL}  ${usernameBasicAuth}  ${passwordBasicAuth}  ${expected_response}
    ${response} =  Basic Auth Request  ${HTTPBIN_HOST}  ${usernameURL}  ${passwordURL}  ${usernameBasicAuth}  ${passwordBasicAuth}
     RequestsChecker.Check Status Code  ${expected_response}   ${response}
