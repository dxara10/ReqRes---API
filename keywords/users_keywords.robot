*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    Collections
Resource    login_keywords.robot

*** Variables ***
${BASE_URL}          https://reqres.in
${USERS_ENDPOINT}    /api/users
${HEADERS}           {"Content-Type": "application/json"}

*** Keywords ***
Criar Sessão API
    [Documentation]    Cria uma sessão para a API ReqRes
    Create Session    api    ${BASE_URL}    headers=${HEADERS}

Listar Usuários Por Página
    [Arguments]    ${page}    ${expected_status}
    [Documentation]    Lista usuários informando a página e valida o status code
    ${response}=    GET On Session    api    url=${USERS_ENDPOINT}?page=${page}
    Log    ${response.json()}
    Validar Status Code    ${response}    ${expected_status}

Buscar Usuário Por ID
    [Arguments]    ${user_id}    ${expected_status}
    [Documentation]    Busca usuário pelo ID e valida o status code
    ${response}=    GET On Session    api    url=${USERS_ENDPOINT}/${user_id}
    Log    ${response.json()}
    Validar Status Code    ${response}    ${expected_status}

Atualizar Usuário Com PUT
    [Arguments]    ${user_id}    ${payload}    ${expected_status}
    [Documentation]    Atualiza completamente um usuário e valida o status code
    ${response}=    PUT On Session    api    url=${USERS_ENDPOINT}/${user_id}    json=${payload}
    Log    ${response.json()}
    Validar Status Code    ${response}    ${expected_status}
    Should Contain    ${response.json()}    updatedAt

Atualizar Usuário Com PATCH
    [Arguments]    ${user_id}    ${payload}    ${expected_status}
    [Documentation]    Atualiza parcialmente um usuário e valida o status code
    ${response}=    PATCH On Session    api    url=${USERS_ENDPOINT}/${user_id}    json=${payload}
    Log    ${response.json()}
    Validar Status Code    ${response}    ${expected_status}
    Should Contain    ${response.json()}    updatedAt

Deletar Usuário
    [Arguments]    ${user_id}    ${expected_status}
    [Documentation]    Deleta um usuário pelo ID e valida o status code
    ${response}=    DELETE On Session    api    url=${USERS_ENDPOINT}/${user_id}
    Log    ${response.status_code}
    Validar Status Code    ${response}    ${expected_status}

Validar Status Code
    [Arguments]    ${response}    ${expected_status}
    [Documentation]    Valida se o status code retornado é o esperado
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}