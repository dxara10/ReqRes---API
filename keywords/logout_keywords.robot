*** Settings ***
Documentation    Keywords para o endpoint de logout
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}         https://reqres.in
${LOGOUT_ENDPOINT}  /api/logout
${API_KEY}          reqres-free-v1

*** Keywords ***
Logout With Api Key
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    logout    ${BASE_URL}    headers=${headers}
    ${response}=    Post Request    logout    ${LOGOUT_ENDPOINT}
    [Return]    ${response}

Logout Without Api Key
    Create Session    logout_no_key    ${BASE_URL}
    ${response}=    Post Request    logout_no_key    ${LOGOUT_ENDPOINT}
    [Return]    ${response}