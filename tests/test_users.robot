*** Settings ***
Resource    ../keywords/users_keywords.robot
Resource    ../keywords/login_keywords.robot

Suite Setup    Criar Sessão API

*** Test Cases ***

Listar Usuários - Página Válida
    Listar Usuários Por Página    1    200

Listar Usuários - Página Inexistente
    Listar Usuários Por Página    999    200

Buscar Usuário - ID Válido
    Buscar Usuário Por ID    2    200

Buscar Usuário - ID Inexistente
    Buscar Usuário Por ID    23    404

Atualizar Usuário - PUT - ID Válido
    ${payload}=    Create Dictionary    name=John    job=Developer
    Atualizar Usuário Com PUT    2    ${payload}    200

Atualizar Usuário - PUT - ID Inexistente
    ${payload}=    Create Dictionary    name=Jane    job=Tester
    Atualizar Usuário Com PUT    9999    ${payload}    200

Atualizar Usuário - PATCH - ID Válido
    ${payload}=    Create Dictionary    job=QA
    Atualizar Usuário Com PATCH    2    ${payload}    200

Atualizar Usuário - PATCH - ID Inexistente
    ${payload}=    Create Dictionary    job=DevOps
    Atualizar Usuário Com PATCH    9999    ${payload}    200

Deletar Usuário - ID Válido
    Deletar Usuário    2    204

Deletar Usuário - ID Inexistente
    Deletar Usuário    9999    204