*** Settings ***
Documentation    Keywords para interagir e validar o endpoint de logout
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}         https://reqres.in
${LOGOUT_ENDPOINT}  /api/logout
${API_KEY}          reqres-free-v1

*** Keywords ***
Realizar Logout Com Api Key
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    logout_session    ${BASE_URL}    headers=${headers}
    ${response}=    Post Request    logout_session    ${LOGOUT_ENDPOINT}
    [Return]    ${response}

Validar Logout Com Sucesso
    ${response}=    Realizar Logout Com Api Key
    Should Be Equal As Integers    ${response.status_code}    200

Realizar Logout Sem Api Key
    Create Session    logout_no_key_session    ${BASE_URL}
    ${response}=    Post Request    logout_no_key_session    ${LOGOUT_ENDPOINT}
    [Return]    ${response}

Validar Erro Logout Sem Api Key
    ${response}=    Realizar Logout Sem Api Key
    Should Be Equal As Integers    ${response.status_code}    401
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    Missing API key
