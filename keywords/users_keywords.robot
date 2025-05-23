*** Settings ***
Library    RequestsLibrary
Library    BuiltIn

*** Variables ***
${BASE_URL}       https://reqres.in
${USERS_ENDPOINT}    /api/users
${headers}        {"Content-Type": "application/json"}

*** Keywords ***
Criar Sessão
    [Documentation]    Cria uma sessão para requisições à API ReqRes
    Create Session    api    ${BASE_URL}  headers=${headers}

Enviar Requisição GET de Listar Usuários
    [Arguments]    ${page}
    [Documentation]    Envia uma requisição GET para listar usuários na página especificada
    ${response}=    GET On Session    api    url=${USERS_ENDPOINT}?page=${page}
    [Return]    ${response}

Enviar Requisição GET de Buscar Usuário por ID
    [Arguments]    ${user_id}
    [Documentation]    Envia uma requisição GET para buscar um usuário pelo ID
    ${response}=    GET On Session    api    url=${USERS_ENDPOINT}/${user_id}
    [Return]    ${response}

Validar Status Code
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}

Enviar Requisição PUT de Atualizar Usuário por ID
    [Arguments]    ${user_id}    ${payload}
    [Documentation]    Envia uma requisição PUT para atualizar um usuário pelo ID
    ${response}=    PUT On Session    api    url=${USERS_ENDPOINT}/${user_id}    json=${payload}
    RETURN    ${response}

Enviar Requisição PATCH de Atualizar Usuário por ID
    [Arguments]    ${user_id}    ${payload}
    [Documentation]    Envia uma requisição PATCH para atualizar parcialmente um usuário pelo ID
    ${response}=    PATCH On Session    api    url=${USERS_ENDPOINT}/${user_id}    json=${payload}
    RETURN    ${response}

Enviar Requisição DELETE de Deletar Usuário por ID
    [Arguments]    ${user_id}
    [Documentation]    Envia uma requisição DELETE para deletar um usuário pelo ID
    ${response}=    DELETE On Session    api    url=${USERS_ENDPOINT}/${user_id}
    RETURN    ${response}