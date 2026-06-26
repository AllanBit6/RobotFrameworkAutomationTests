*** Settings ***
Resource   ../resources/keywords.robot
Test Setup   Preparar caso de prueba
Test Teardown   Finalizar caso de prueba

*** Test Cases ***
TC-001 Validar pagina publica desde Excel
    [Tags]   TC-001
    Abrir navegador   ${url}   ${browser}
    Validar titulo de pagina   ${title}
    Validar texto visible   ${expected_text}
