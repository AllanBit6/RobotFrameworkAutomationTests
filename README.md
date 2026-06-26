# Proyecto base de automatizacion con Robot Framework

Este repositorio es una plantilla corta para crear proyectos de pruebas
automatizadas con Robot Framework, SeleniumLibrary, datos desde Excel y
evidencia por caso en HTML/PDF.

La idea es poder clonar este repo, cambiar el Excel, escribir nuevos casos y
mantener siempre la misma salida de reportes.

## Que genera

Cada ejecucion crea archivos en `results/`:

- `output.xml`: resultado tecnico de Robot Framework.
- `log.html`: detalle completo de ejecucion.
- `report.html`: resumen nativo de Robot Framework.
- `evidencia-*.html`: evidencia ejecutiva por caso.
- `evidencia-*.pdf`: evidencia ejecutiva por caso.
- `*.png`: capturas tomadas durante la prueba.

## Estructura

```text
tests/
  regresive.robot          Suite principal de ejemplo
resources/
  keywords.robot           Keywords reutilizables de Selenium y evidencia
  datos_excel.py           Libreria para cargar variables desde Excel
  reportes.py              Libreria Python para HTML/PDF
variables/
  variables.xlsx           Datos de entrada por caso
  variables.py             Lector generico del Excel
robot.args                 Argumentos comunes de Robot
requirements.txt           Dependencias Python
results/                   Reportes generados
```

## Requisitos

Instala Python 3.10 o superior y un navegador compatible con Selenium.
En Windows puedes validar Edge o Chrome con:

```powershell
where msedge
where chrome
```

Instala las dependencias:

```powershell
python -m pip install -r requirements.txt
```

Para una instalacion minima en un proyecto nuevo:

```powershell
python -m pip install robotframework robotframework-seleniumlibrary openpyxl fpdf2
```

## Ejecutar

Ejecutar toda la suite:

```powershell
python -m robot --argumentfile robot.args tests/regresive.robot
```

Ejecutar indicando la carpeta de salida manualmente:

```powershell
python -m robot --outputdir results tests/regresive.robot
```

Ejecutar un caso especifico:

```powershell
python -m robot --outputdir results -t "TC-001 Validar pagina publica desde Excel" tests/regresive.robot
```

Validar sintaxis sin abrir navegador:

```powershell
python -m robot --dryrun --outputdir results tests/regresive.robot
```

## Como crear un caso de prueba

1. Crea una hoja en `variables/variables.xlsx`.
2. Nombra la hoja igual que el codigo del caso, por ejemplo `TC-002`.
3. En la fila 1 coloca los nombres de variables: `url`, `browser`, `title`,
   `expected_text`, etc.
4. En la fila 2 coloca los valores que usara el caso.
5. Crea el caso en `tests/regresive.robot`.
6. Agrega el tag con el mismo nombre de la hoja.
7. Escribe solo los pasos de negocio; el `Test Setup` carga el Excel y abre el
   reporte automaticamente.

Ejemplo:

```robot
*** Test Cases ***
TC-002 Buscar texto desde Excel
    [Tags]   TC-002
    Abrir navegador   ${url}   ${browser}
    Validar texto visible   ${expected_text}
```

La suite ya incluye este setup:

```robot
Test Setup   Preparar caso de prueba
Test Teardown   Finalizar caso de prueba
```

`Preparar caso de prueba` toma el tag `TC-XXX`, busca una hoja con ese mismo
nombre en `variables/variables.xlsx`, convierte los encabezados en variables de
Robot y arranca el reporte.

## Formato del Excel

Cada hoja representa un caso o modulo de prueba.

Ejemplo de hoja `TC-001`:

| url | browser | title | expected_text |
| --- | --- | --- | --- |
| https://www.example.com | Edge | Example Domain | Example Domain |

Reglas:

- La primera fila siempre son encabezados.
- Cada encabezado se convierte en variable Robot: `url` sera `${url}`.
- Los encabezados se normalizan a minusculas y guion bajo: `Expected Text`
  sera `${expected_text}`.
- La fila 2 es la primera fila de datos.
- Puedes agregar columnas nuevas sin modificar `variables.py`.
- Si quieres usar otra fila de datos, pasa el numero como segundo argumento:

```robot
[Setup]   Preparar caso de prueba   TC-001   2
```

Tambien puedes cargar una hoja especifica manualmente en un caso especial:

```robot
Preparar caso de prueba   TC-003
```

## Evidencia HTML/PDF

La libreria `resources/reportes.py` agrega estas keywords:

- `Iniciar caso de prueba`
- `Registrar evidencia`
- `Finalizar caso de prueba`

La suite usa:

```robot
Test Setup      Preparar caso de prueba
Test Teardown   Finalizar caso de prueba
```

Eso permite que, aunque el caso falle, se capture el estado final, se cierre el
navegador y se escriban los archivos `evidencia-*.html` y `evidencia-*.pdf` en
`results/`.

Las keywords de `resources/keywords.robot` ya registran evidencia al abrir el
navegador y despues de cada validacion exitosa. Para agregar una evidencia
manual:

```robot
Registrar evidencia   Se completo el paso de busqueda
```

## Como clonar para otro proyecto

1. Copia o clona este repositorio.
2. Cambia `variables/variables.xlsx` por el Excel del nuevo proyecto.
3. Mantiene una hoja por caso: `TC-001`, `TC-002`, etc.
4. Cambia o agrega keywords en `resources/keywords.robot`.
5. Crea suites nuevas dentro de `tests/`.
6. En cada suite importa `../resources/keywords.robot`, usa
   `Test Setup   Preparar caso de prueba` y `Test Teardown   Finalizar caso de prueba`.
7. Ejecuta con `python -m robot --argumentfile robot.args tests/regresive.robot`.
8. Revisa `results/report.html` para diagnostico tecnico.
9. Usa `results/evidencia-*.pdf` como evidencia ejecutiva.

## Problemas comunes

- Si no abre navegador, valida que Selenium pueda encontrar el navegador.
- Si faltan variables, revisa que el nombre de la hoja y los encabezados del
  Excel coincidan con lo que usa el `.robot`.
- Si no aparece el PDF, revisa `results/log.html`; el teardown registra las
  rutas o errores de evidencia.
- Si el caso falla por titulo o texto esperado, corrige los valores del Excel.
