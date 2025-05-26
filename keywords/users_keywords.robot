*** Settings ***
Documentation    Testes automatizados para o endpoint de usuarios
Resource    ../keywords/login_keywords.robot
Resource    ../keywords/users_keywords.robot
Library    RequestsLibrary

Library    ../venv/lib/python3.12/site-packages/RequestsLibrary/__init__.py

*** Variables ***
${email}        eve.holt@reqres.in
${password}    cityslicka
${token_auth}    QpwL5tke4Pnpja7X4


*** Keywords ***
Get Listar Usuarios 200    
    &{payload}    Create Dictionary    id=0    email=string    first_name=string    last_name=string    avatar=string 
    ${response}=    Get Request    login_session    /api/users/2    params=${payload}
    Log    Response: ${response.json()}
    Log    Status Code: ${response.status_code}
    Log    Headers: ${response.headers}
    Log    Content-Type: ${response.headers['Content-Type']}
    Should Be Equal As Integers    ${response.status_code}    200


Get Usuario Por Id 200
    [Arguments]    ${id}
    &{payload}    Create Dictionary    id=${id}    email=string    first_name=string    last_name=string    avatar=string 
    ${response}=    Get Request    login_session    /api/users/${id}    params=${payload}
    Log    Response: ${response.json()}
    Log    Status Code: ${response.status_code}
    Log    Headers: ${response.headers}
    Log    Content-Type: ${response.headers['Content-Type']}
    Should Be Equal As Integers    ${response.status_code}    200


Get Usuario Por Id 404
    [Arguments]    ${id}
    &{payload}    Create Dictionary    id=${id}    email=string    first_name=string    last_name=string    avatar=string 
    ${response}=    Get Request    login_session    /api/users/${id}    params=${payload}
    Log    Response: ${response.json()}
    Log    Status Code: ${response.status_code}
    Log    Headers: ${response.headers}
    Log    Content-Type: ${response.headers['Content-Type']}
    Should Be Equal As Integers    ${response.status_code}    404

PUT Atualizar Usuario Por Id
    [Arguments]    ${id}
    &{payload}    Create Dictionary    id=${id}    email=string    first_name=string    last_name=string    avatar=string 
    ${response}=    Put Request    login_session    /api/users/${id}    json=${payload}
    Log    Response: ${response.json()}
    Log    Status Code: ${response.status_code}
    Log    Headers: ${response.headers}
    Log    Content-Type: ${response.headers['Content-Type']}
    Should Be Equal As Integers    ${response.status_code}    200

DELETE Deletar Usuario Por Id
    [Arguments]    ${id}
    ${response}=    Delete Request    login_session    /api/users/${id}
    Log    Status Code: ${response.status_code}
    Log    Headers: ${response.headers}
    ${content_length}=    Get From Dictionary    ${response.headers}    Content-Length    NOT PRESENT
    Log    Content-Length: ${content_length}
    Should Be Equal As Integers    ${response.status_code}    204

