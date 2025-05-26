*** Settings ***
Documentation    Keywords para interagir e validar o endpoint de resource
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}           https://reqres.in
${RESOURCE_ENDPOINT}  /api/unknown
${API_KEY}            reqres-free-v1

*** Keywords ***
Validar Buscar Lista De Resources Com Sucesso
    ${headers}=    Create Dictionary    
    ...    x-api-key=${API_KEY}

    Create Session    resource_list    ${BASE_URL}    headers=${headers}
    ${response}=    Get Request    resource_list    ${RESOURCE_ENDPOINT}
    Should Be Equal As Integers    ${response.status_code}    200
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Be True    ${data} != []
    ${is_list}=    Evaluate    isinstance(${data}, list)
    Should Be True    ${is_list}

Validar Buscar Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${headers}=    Create Dictionary    
    ...    x-api-key=${API_KEY}

    Create Session    resource_by_id    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    ${RESOURCE_ENDPOINT}/${resource_id}
    ${response}=    Get Request    resource_by_id    ${endpoint}
    Should Be Equal As Integers    ${response.status_code}    200
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Be Equal As Integers    ${data['id']}    ${resource_id}
    Should Not Be Empty    ${data['name']}
    Should Not Be Empty    ${data['color']}
    Should Not Be Empty    ${data['pantone_value']}

Validar Atualizar Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${payload}=    Create Dictionary    
    ...    name=novo_nome    
    ...    color=#FFFFFF

    ${headers}=    Create Dictionary    
    ...    x-api-key=${API_KEY}

    Create Session    update_resource    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    ${RESOURCE_ENDPOINT}/${resource_id}
    ${response}=    Put Request    update_resource    ${endpoint}    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${updated_at}=    Get From Dictionary    ${response.json()}    updatedAt
    Should Not Be Empty    ${updated_at}

Validar Atualizar Parcialmente Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${payload}=    Create Dictionary    
    ...    name=patch_nome

    ${headers}=    Create Dictionary    
    ...    x-api-key=${API_KEY}

    Create Session    patch_resource    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    ${RESOURCE_ENDPOINT}/${resource_id}
    ${response}=    Patch Request    patch_resource    ${endpoint}    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${updated_at}=    Get From Dictionary    ${response.json()}    updatedAt
    Should Not Be Empty    ${updated_at}

Validar Deletar Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    delete_resource    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    ${RESOURCE_ENDPOINT}/${resource_id}
    ${response}=    Delete Request    delete_resource    ${endpoint}
    Should Be Equal As Integers    ${response.status_code}    204
