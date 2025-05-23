*** Settings ***
Library           Collections
Library           RequestsLibrary
Resource          ../keywords/users_keywords.robot

Suite Setup       Criar Sessão

*** Test Cases ***
Listar Usuários Com Página Válida
    [Documentation]    Testa a listagem de usuários com uma página válida
    ${response}=    Enviar Requisição GET de Listar Usuários    1
    Log    ${response.json()}
    Validar Status Code    ${response}    200

Listar Usuários Com Página Inválida
    [Documentation]    Testa a listagem de usuários com uma página inexistente
    ${response}=    Enviar Requisição GET de Listar Usuários    999
    Log    ${response.json()}
    Validar Status Code    ${response}    200


Buscar Usuário por ID Válido
    [Documentation]    Testa a busca de um usuário existente pelo ID
    ${response}=    Enviar Requisição GET de Buscar Usuário por ID    2
    Log    ${response.json()}
    Validar Status Code    ${response}    200

Buscar Usuário por ID Inválido
    [Documentation]    Testa a busca de um usuário inexistente pelo ID sem autenticação
    ${response}=    users_keywords.Enviar Requisição GET de Buscar Usuário por ID    23
    Log    ${response.json()}
    Validar Status Code    ${response}    401

Atualizar Usuário com ID Válido
    [Documentation]    Testa a atualização de um usuário existente pelo ID
    ${payload}=    Create Dictionary    name=John    job=Developer
    ${response}=    Enviar Requisição PUT de Atualizar Usuário por ID    2    ${payload}
    Log    ${response.json()}
    Validar Status Code    ${response}    200
    Should Contain    ${response.json()}    updatedAt

Atualizar Usuário com ID Inválido
    [Documentation]    Testa a atualização de um usuário inexistente pelo ID
    ${payload}=    Create Dictionary    name=Jane    job=Tester
    ${response}=    Enviar Requisição PUT de Atualizar Usuário por ID    9999    ${payload}
    Log    ${response.json()}
    Validar Status Code    ${response}    200
    Should Contain    ${response.json()}    updatedAt

Atualizar Parcialmente Usuário com ID Válido
    [Documentation]    Testa a atualização parcial de um usuário existente pelo ID
    ${payload}=    Create Dictionary    job=QA
    ${response}=    Enviar Requisição PATCH de Atualizar Usuário por ID    2    ${payload}
    Log    ${response.json()}
    Validar Status Code    ${response}    200
    Should Contain    ${response.json()}    updatedAt

Atualizar Parcialmente Usuário com ID Inválido
    [Documentation]    Testa a atualização parcial de um usuário inexistente pelo ID
    ${payload}=    Create Dictionary    job=DevOps
    ${response}=    Enviar Requisição PATCH de Atualizar Usuário por ID    9999    ${payload}
    Log    ${response.json()}
    Validar Status Code    ${response}    200
    Should Contain    ${response.json()}    updatedAt

Deletar Usuário com ID Válido
    [Documentation]    Testa a exclusão de um usuário existente pelo ID
    ${response}=    Enviar Requisição DELETE de Deletar Usuário por ID    2
    Log    ${response.status_code}
    Validar Status Code    ${response}    204

Deletar Usuário com ID Inválido
    [Documentation]    Testa a exclusão de um usuário inexistente pelo ID
    ${response}=    Enviar Requisição DELETE de Deletar Usuário por ID    9999
    Log    ${response.status_code}
    Validar Status Code    ${response}    204