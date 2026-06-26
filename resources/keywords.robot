*** Settings ***
Library   SeleniumLibrary
Library   reportes.py
Library   datos_excel.py

*** Keywords ***
Preparar caso de prueba
    [Arguments]   ${codigo_caso}=${EMPTY}   ${fila}=1
    ${codigo_cargado}=   Cargar variables de excel   ${codigo_caso}   ${fila}
    Iniciar caso de prueba
    Registrar evidencia   Datos cargados desde Excel para ${codigo_cargado}   False

Abrir navegador
    [Arguments]   ${url}   ${browser}
    Open Browser   ${url}   ${browser}
    Maximize Browser Window
    Registrar evidencia   Navegador abierto en ${url}

Validar titulo de pagina
    [Arguments]   ${title}
    Title Should Be   ${title}
    Registrar evidencia   Titulo validado: ${title}

Validar texto visible
    [Arguments]   ${expected_text}
    Page Should Contain   ${expected_text}
    Registrar evidencia   Texto visible validado: ${expected_text}

Cerrar navegador
    Close Browser
