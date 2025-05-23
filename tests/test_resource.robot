*** Settings ***
Documentation    Teste para o endpoint de resource
Resource    ../keywords/resource_keywords.robot

*** Test Cases ***
Buscar Lista De Resources Com Sucesso
    ${response}=    Get Resource List
    Should Be Equal As Integers    ${response.status_code}    200
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Be True    ${data} != []
    ${is_list}=    Evaluate    isinstance(${data}, list)
    Should Be True    ${is_list}

Buscar Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${response}=    Get Resource By Id    ${resource_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Be Equal As Integers    ${data['id']}    ${resource_id}
    Should Not Be Empty    ${data['name']}
    Should Not Be Empty    ${data['color']}
    Should Not Be Empty    ${data['pantone_value']}

Atualizar Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${payload}=    Create Dictionary    name=novo_nome    color=#FFFFFF
    ${response}=    Update Resource By Id    ${resource_id}    ${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${updated_at}=    Get From Dictionary    ${response.json()}    updatedAt
    Should Not Be Empty    ${updated_at}

Atualizar Parcialmente Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${payload}=    Create Dictionary    name=patch_nome
    ${response}=    Patch Resource By Id    ${resource_id}    ${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${updated_at}=    Get From Dictionary    ${response.json()}    updatedAt
    Should Not Be Empty    ${updated_at}

Deletar Resource Por Id Com Sucesso
    ${resource_id}=    Set Variable    2
    ${response}=    Delete Resource By Id    ${resource_id}
    Should Be Equal As Integers    ${response.status_code}    204