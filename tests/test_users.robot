*** Settings ***
Resource    ../keywords/users_keywords.robot
Resource    ../keywords/login_keywords.robot

Suite Setup    Criar Sessão API

*** Test Cases ***
Login com Sucesso
    Validar Login Com Sucesso

Login Falha - Sem Email
    Validar Erro Sem Email

Login Falha - Sem Senha
    Validar Erro Sem Senha

Login Falha - Credenciais Inválidas
    Validar Erro Credenciais Invalidas

Listar Usuários - Página Válida
    Validar Login Com Sucesso
    Listar Usuários Por Página    1    200

Listar Usuários - Página Inexistente
    Validar Login Com Sucesso
    Listar Usuários Por Página    999    200

Buscar Usuário - ID Válido
    Validar Login Com Sucesso
    Buscar Usuário Por ID    2    200

Buscar Usuário - ID Inexistente
    Validar Login Com Sucesso
    Buscar Usuário Por ID    23    404

Atualizar Usuário - PUT - ID Válido
    Validar Login Com Sucesso
    ${payload}=    Create Dictionary    name=John    job=Developer
    Atualizar Usuário Com PUT    2    ${payload}    200

Atualizar Usuário - PUT - ID Inexistente
    Validar Login Com Sucesso
    ${payload}=    Create Dictionary    name=Jane    job=Tester
    Atualizar Usuário Com PUT    9999    ${payload}    200

Atualizar Usuário - PATCH - ID Válido
    Validar Login Com Sucesso
    ${payload}=    Create Dictionary    job=QA
    Atualizar Usuário Com PATCH    2    ${payload}    200

Atualizar Usuário - PATCH - ID Inexistente
    Validar Login Com Sucesso
    ${payload}=    Create Dictionary    job=DevOps
    Atualizar Usuário Com PATCH    9999    ${payload}    200

Deletar Usuário - ID Válido
    Validar Login Com Sucesso
    Deletar Usuário    2    204

Deletar Usuário - ID Inexistente
    Validar Login Com Sucesso
    Deletar Usuário    9999    204

