*** Settings ***
Documentation    Keywords para interagir e validar o endpoint de login
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}         https://reqres.in
${LOGIN_ENDPOINT}   /api/login
${API_KEY}          reqres-free-v1

*** Keywords ***
Realizar Login
    [Arguments]    ${email}    ${password}
    ${headers}=    Create Dictionary    
    ...    x-api-key=${API_KEY}
    
    Create Session    login_session    
    ...    ${BASE_URL}    
    ...    headers=${headers}

    ${payload}=    Create Dictionary    
    ...    email=${email}    
    ...    password=${password}

    ${response}=    Post Request    login_session    
    ...    ${LOGIN_ENDPOINT}    
    ...    json=${payload}

    [Return]    ${response}

Token De Autenticacao
    [Arguments]    ${email}    ${password}
    ${response}=    Realizar Login    ${email}    ${password}
    
    ${json}=    To Json    ${response.content}
    ${token}=    Set Variable    ${json['token']}

    Set Global Variable    ${AUTH_TOKEN}    ${token}


Validar Login Com Sucesso
    ${email}=    Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable    cityslicka
    ${response}=    Realizar Login    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Get From Dictionary    ${response.json()}    token
    Should Not Be Empty    ${token}

Validar Erro Sem Email
    ${email}=    Set Variable
    ${password}=    Set Variable    cityslicka
    ${response}=    Realizar Login    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    email

Validar Erro Sem Senha
    ${email}=    Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable
    ${response}=    Realizar Login    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    password

Validar Erro Credenciais Invalidas
    ${email}=    Set Variable    usuario@invalido.com
    ${password}=    Set Variable    senhaerrada
    ${response}=    Realizar Login    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Not Be Empty    ${error}
