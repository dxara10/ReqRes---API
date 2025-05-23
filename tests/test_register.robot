*** Settings ***
Documentation    Teste de cenário feliz para registro de usuário
Resource    ../keywords/register_keywords.robot

*** Test Cases ***
Registro Com Sucesso
    ${username}=    Set Variable    usuario.teste
    ${email}=       Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable    pistol
    ${response}=    Register User    ${username}    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    200
    ${id}=    Get From Dictionary    ${response.json()}    id
    ${token}=    Get From Dictionary    ${response.json()}    token
    Should Not Be Equal    ${id}    ${EMPTY}
    Should Not Be Empty    ${token}

Registro Sem Email
    ${username}=    Set Variable    usuario.teste
    ${email}=       Set Variable
    ${password}=    Set Variable    pistol
    ${response}=    Register User    ${username}    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    email

Registro Sem Senha
    ${username}=    Set Variable    usuario.teste
    ${email}=       Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable
    ${response}=    Register User    ${username}    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    password

*** Keywords ***