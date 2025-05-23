*** Settings ***
Documentation    Keywords para o endpoint de registro
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}           https://reqres.in
${REGISTER_ENDPOINT}  /api/register
${API_KEY}            reqres-free-v1

*** Keywords ***
Register User
    [Arguments]    ${username}    ${email}    ${password}
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    register    ${BASE_URL}    headers=${headers}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    Post Request    register    ${REGISTER_ENDPOINT}    json=${payload}
    [Return]    ${response}