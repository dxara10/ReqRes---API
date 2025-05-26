*** Settings ***
Documentation    Keywords para interagir e validar o endpoint de registro
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}           https://reqres.in
${REGISTER_ENDPOINT}  /api/register
${API_KEY}            reqres-free-v1

*** Keywords ***
Realizar Registro
    [Arguments]    ${username}    ${email}    ${password}
    ${headers}=    Create Dictionary    
    ...    x-api-key=${API_KEY}
    Create Session    register_session    ${BASE_URL}    headers=${headers}
    ${payload}=    Create Dictionary    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    Post Request    register_session    ${REGISTER_ENDPOINT}    json=${payload}
    [Return]    ${response}

Validar Registro Com Sucesso
    ${username}=    Set Variable    usuario.teste
    ${email}=       Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable    pistol
    ${response}=    Realizar Registro    ${username}    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    200
    ${id}=    Get From Dictionary    ${response.json()}    id
    ${token}=    Get From Dictionary    ${response.json()}    token
    Should Not Be Equal    ${id}    ${EMPTY}
    Should Not Be Empty    ${token}

Validar Erro Registro Sem Email
    ${username}=    Set Variable    usuario.teste
    ${email}=       Set Variable
    ${password}=    Set Variable    pistol
    ${response}=    Realizar Registro    ${username}    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    email

Validar Erro Registro Sem Senha
    ${username}=    Set Variable    usuario.teste
    ${email}=       Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable
    ${response}=    Realizar Registro    ${username}    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    password
