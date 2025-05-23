*** Settings ***
Documentation    Testes para o endpoint de login
Resource    ../keywords/login_keywords.robot

*** Test Cases ***
Login Com Sucesso
    ${username}=    Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable    cityslicka
    ${response}=    Login With Credentials    ${username}    ${password}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Get From Dictionary    ${response.json()}    token
    Should Not Be Empty    ${token}

Login Sem Email
    ${username}=    Set Variable
    ${password}=    Set Variable    cityslicka
    ${response}=    Login With Credentials    ${username}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    email

Login Sem Senha
    ${username}=    Set Variable    eve.holt@reqres.in
    ${password}=    Set Variable
    ${response}=    Login With Credentials    ${username}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    password

Login Com Credenciais Invalidas
    ${username}=    Set Variable    usuario@invalido.com
    ${password}=    Set Variable    senhaerrada
    ${response}=    Login With Credentials    ${username}    ${password}
    Should Be Equal As Integers    ${response.status_code}    400
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Not Be Empty    ${error}

*** Keywords ***