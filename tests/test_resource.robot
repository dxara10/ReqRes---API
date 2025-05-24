*** Settings ***
Documentation    Testes automatizados para o endpoint de resource
Resource    ../keywords/resource_keywords.robot

*** Test Cases ***
Buscar Lista De Resources Com Sucesso
    Validar Buscar Lista De Resources Com Sucesso

Buscar Resource Por Id Com Sucesso
    Validar Buscar Resource Por Id Com Sucesso

Atualizar Resource Por Id Com Sucesso
    Validar Atualizar Resource Por Id Com Sucesso

Atualizar Parcialmente Resource Por Id Com Sucesso
    Validar Atualizar Parcialmente Resource Por Id Com Sucesso

Deletar Resource Por Id Com Sucesso
    Validar Deletar Resource Por Id Com Sucesso
