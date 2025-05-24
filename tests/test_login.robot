*** Settings ***
Documentation    Testes automatizados para o endpoint de login
Resource    ../keywords/login_keywords.robot

*** Test Cases ***
Login Com Sucesso
    Validar Login Com Sucesso

Login Sem Email
    Validar Erro Sem Email

Login Sem Senha
    Validar Erro Sem Senha

Login Com Credenciais Invalidas
    Validar Erro Credenciais Invalidas
