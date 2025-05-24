*** Settings ***
Documentation    Testes automatizados para o endpoint de registro
Resource    ../keywords/register_keywords.robot

*** Test Cases ***
Registro Com Sucesso
    Validar Registro Com Sucesso

Registro Sem Email
    Validar Erro Registro Sem Email

Registro Sem Senha
    Validar Erro Registro Sem Senha
