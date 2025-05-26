*** Settings ***
Documentation    Testes automatizados para o endpoint de usuarios
Resource    ../keywords/login_keywords.robot
Resource    ../keywords/users_keywords.robot
Library    RequestsLibrary

Library    ../venv/lib/python3.12/site-packages/RequestsLibrary/__init__.py

*** Variables ***
${email}        eve.holt@reqres.in
${password}    cityslicka


*** Test Cases ***
Listar Usuarios 200
    [Documentation]    Testa a listagem de usuarios com sucesso
    Token De Autenticacao    ${email}    ${password}
    Get Listar Usuarios 200

Buscar Usuário - ID Válido
    [Documentation]    Testa a busca de um usuário com ID válido
    Token De Autenticacao    ${email}    ${password}
    Get Usuario Por Id 200    2

Buscar Usuário - ID Inválido
    [Documentation]    Testa a busca de um usuário com ID inválido
    Token De Autenticacao    ${email}    ${password}
    Get Usuario Por Id 404    23

Atualizar Usuário - PUT - ID Válido
    [Documentation]    Testa a atualização de um usuário com ID válido
    Token De Autenticacao    ${email}    ${password}
    PUT Atualizar Usuario Por Id    200

Atualizar Usuário - PUT - ID Inexistente
    [Documentation]    Testa a atualização de um usuário com ID inexistente
    Token De Autenticacao    ${email}    ${password}
    PUT Atualizar Usuario Por Id    9999

Atualizar Usuário - PATCH - ID Válido
    [Documentation]    Testa a atualização parcial de um usuário com ID válido
    Token De Autenticacao    ${email}    ${password}
    PUT Atualizar Usuario Por Id    2

Atualizar Usuário - PATCH - ID Inexistente
    [Documentation]    Testa a atualização parcial de um usuário com ID inexistente
    Token De Autenticacao    ${email}    ${password}
    PUT Atualizar Usuario Por Id    9999

Deletar Usuário - ID Válido
    [Documentation]    Testa a deleção de um usuário com ID válido
    Token De Autenticacao    ${email}    ${password}
    DELETE Deletar Usuario Por Id    2

eletar Usuário - ID Inexistente
    [Documentation]    Testa a deleção de um usuário com ID inexistente
    Token De Autenticacao    ${email}    ${password}
    DELETE Deletar Usuario Por Id    9999
    

*** Keywords ***
