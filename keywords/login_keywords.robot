*** Settings ***
Documentation    Keywords for login page
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}         https://reqres.in
${LOGIN_ENDPOINT}   /api/login

*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    ${headers}=    Create Dictionary    x-api-key=reqres-free-v1
    Create Session    login    ${BASE_URL}    headers=${headers}
    ${payload}=    Create Dictionary    email=${username}    password=${password}
    ${response}=    Post Request    login    ${LOGIN_ENDPOINT}    json=${payload}
    [Return]    ${response}