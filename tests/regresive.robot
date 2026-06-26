*** Settings ***
Resource   ../resources/keywords.robot
Test Teardown   Finalizar caso de prueba

*** Test Cases ***
TC-001 Validar pagina publica desde Excel
    [Tags]   TC-001
    Import Variables   ../variables/variables.py   TC-001
    Iniciar caso de prueba
    Abrir navegador   ${url}   ${browser}
    Validar titulo de pagina   ${title}
    Validar texto visible   ${expected_text}
