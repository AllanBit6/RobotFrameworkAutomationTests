*** Settings ***
Library   SeleniumLibrary
Library   reportes.py
Library   datos_excel.py

*** Keywords ***
# Flujo del caso
Preparar caso de prueba
    [Documentation]   Carga variables desde Excel segun el tag TC-XXX e inicia la evidencia del caso.
    [Arguments]   ${codigo_caso}=${EMPTY}   ${fila}=1
    ${codigo_cargado}=   Cargar variables de excel   ${codigo_caso}   ${fila}
    Iniciar caso de prueba
    Registrar evidencia   Datos cargados desde Excel para ${codigo_cargado}, fila ${fila}   False

# Navegacion
Abrir navegador
    [Documentation]   Abre el navegador en la URL indicada, maximiza la ventana y registra evidencia.
    [Arguments]   ${url}   ${browser}
    Open Browser   ${url}   ${browser}
    Maximize Browser Window
    Registrar evidencia   Navegador abierto en ${url}

Ir a url
    [Documentation]   Navega a una URL usando el navegador ya abierto.
    [Arguments]   ${url}
    Go To   ${url}
    Registrar evidencia   Navegacion realizada a ${url}

Volver pagina
    [Documentation]   Vuelve a la pagina anterior del navegador.
    Go Back
    Registrar evidencia   Volviendo a la pagina anterior

Recargar pagina
    [Documentation]   Recarga la pagina actual.
    Reload Page
    Registrar evidencia   Pagina recargada

# Validaciones
Validar titulo de pagina
    [Documentation]   Valida que el titulo de la pagina sea exactamente el esperado.
    [Arguments]   ${title}
    Title Should Be   ${title}
    Registrar evidencia   Titulo validado: ${title}

Validar texto visible
    [Documentation]   Valida que el texto esperado exista en la pagina.
    [Arguments]   ${expected_text}
    Page Should Contain   ${expected_text}
    Registrar evidencia   Texto visible validado: ${expected_text}

Validar elemento visible
    [Documentation]   Valida que un elemento este visible en pantalla.
    [Arguments]   ${locator}
    Element Should Be Visible   ${locator}
    Registrar evidencia   Elemento visible validado: ${locator}

Validar elemento contiene texto
    [Documentation]   Valida que un elemento contenga el texto esperado.
    [Arguments]   ${locator}   ${expected_text}
    Element Should Contain   ${locator}   ${expected_text}
    Registrar evidencia   Texto validado en ${locator}: ${expected_text}

Validar url contiene
    [Documentation]   Valida que la URL actual contenga el texto esperado.
    [Arguments]   ${expected_text}
    Location Should Contain   ${expected_text}
    Registrar evidencia   URL contiene: ${expected_text}

Validar texto en alert
    [Documentation]   Valida el texto de una alerta y la acepta.
    [Arguments]   ${expected_text}
    Alert Should Be Present   ${expected_text}   

Esperar elemento visible
    [Documentation]   Espera hasta que el elemento este visible.
    [Arguments]   ${locator}   ${timeout}=10s
    Wait Until Element Is Visible   ${locator}   ${timeout}
    Registrar evidencia   Elemento visible despues de espera: ${locator}

# Interacciones
Presionar boton
    [Documentation]   Presiona un elemento tipo button.
    [Arguments]   ${locator}
    Click Button   ${locator}
    Registrar evidencia   Boton presionado: ${locator}

Presionar elemento
    [Documentation]   Presiona cualquier elemento localizable.
    [Arguments]   ${locator}
    Click Element   ${locator}
    Registrar evidencia   Elemento presionado: ${locator}

Introducir texto
    [Documentation]   Escribe texto en un campo sin limpiarlo antes.
    [Arguments]   ${locator}   ${text}
    Input Text   ${locator}   ${text}
    Registrar evidencia   Texto introducido: ${text} en el campo: ${locator}

Limpiar e introducir texto
    [Documentation]   Limpia un campo y luego escribe el texto indicado.
    [Arguments]   ${locator}   ${text}
    Clear Element Text   ${locator}
    Input Text   ${locator}   ${text}
    Registrar evidencia   Texto reemplazado en el campo: ${locator}

Seleccionar opcion por texto
    [Documentation]   Selecciona una opcion visible en un select HTML.
    [Arguments]   ${locator}   ${text}
    Select From List By Label   ${locator}   ${text}
    Registrar evidencia   Opcion seleccionada en ${locator}: ${text}

Obtener texto de elemento
    [Documentation]   Devuelve el texto visible de un elemento.
    [Arguments]   ${locator}
    ${text}=   Get Text   ${locator}
    Registrar evidencia   Texto obtenido desde ${locator}: ${text}   False
    RETURN   ${text}

# Cierre
Cerrar navegador
    [Documentation]   Cierra el navegador actual.
    Close Browser

Cerrar todos los navegadores
    [Documentation]   Cierra todos los navegadores abiertos por Selenium.
    Close All Browsers
