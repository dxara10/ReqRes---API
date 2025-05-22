*** Settings ***
Documentation    Keywords for login page
Resource         ../keywords/users_keywords.robot

*** Test Cases ***
Listar Usuários com Pagina Valida
    Criar Sessão
    ${response}=    Enviar Requisição GET de Listar Usuários    1
    Validar status_code    ${response}    200
    Log    ${response.json()}

Listar Usuários com Página Invalida
    Criar Sessão
    ${response}=    Enviar Requisição GET de Listar Usuários    -1
    Log    ${response.status_code}
    Validar status_code    ${response}    401
    Log    ${response.json()}

