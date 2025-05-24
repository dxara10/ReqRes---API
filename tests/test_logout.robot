*** Settings ***
Documentation    Testes automatizados para o endpoint de logout
Resource    ../keywords/logout_keywords.robot

*** Test Cases ***
Logout Com Sucesso
    Validar Logout Com Sucesso

Logout Sem Api Key
    Validar Erro Logout Sem Api Key
