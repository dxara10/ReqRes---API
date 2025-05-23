*** Settings ***
Documentation    Keywords para o endpoint de resource
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}           https://reqres.in
${RESOURCE_ENDPOINT}  /api/unknown/2
${API_KEY}            reqres-free-v1

*** Keywords ***
Get Resource List
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    resource_list    ${BASE_URL}    headers=${headers}
    ${response}=    Get Request    resource_list    /api/unknown
    [Return]    ${response}

Get Resource By Id
    [Arguments]    ${resource_id}
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    resource_by_id    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    /api/unknown/${resource_id}
    ${response}=    Get Request    resource_by_id    ${endpoint}
    [Return]    ${response}

Update Resource By Id
    [Arguments]    ${resource_id}    ${payload}
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    update_resource    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    /api/unknown/${resource_id}
    ${response}=    Put Request    update_resource    ${endpoint}    json=${payload}
    [Return]    ${response}

Patch Resource By Id
    [Arguments]    ${resource_id}    ${payload}
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    patch_resource    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    /api/unknown/${resource_id}
    ${response}=    Patch Request    patch_resource    ${endpoint}    json=${payload}
    [Return]    ${response}

Delete Resource By Id
    [Arguments]    ${resource_id}
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    delete_resource    ${BASE_URL}    headers=${headers}
    ${endpoint}=    Set Variable    /api/unknown/${resource_id}
    ${response}=    Delete Request    delete_resource    ${endpoint}
    [Return]    ${response}