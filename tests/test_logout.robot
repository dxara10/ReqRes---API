*** Settings ***
Documentation    Testes para o endpoint de logout
Resource    ../keywords/logout_keywords.robot

*** Test Cases ***
Logout Com Sucesso
    ${response}=    Logout With Api Key
    Should Be Equal As Integers    ${response.status_code}    200

Logout Sem Api Key
    ${response}=    Logout Without Api Key
    Should Be Equal As Integers    ${response.status_code}    401
    ${error}=    Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    Missing API key