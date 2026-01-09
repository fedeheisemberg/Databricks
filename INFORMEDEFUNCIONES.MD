## Glosario Técnico de Sintaxis y Funciones Usadas

## A. Ingesta y Persistencia de Datos (Bronze Layer)

### SparkSession

**`SparkSession.builder.getOrCreate()`**

Punto de entrada principal a Spark. Permite crear DataFrames, leer datos, escribir tablas y ejecutar SQL. En Databricks ya viene preconfigurada, pero sigue siendo el objeto lógico que representa la sesión de trabajo distribuida.

---

### Lectura de datos

**`spark.read.format()`**

Define explícitamente el formato de entrada de los datos (csv, parquet, json, delta). Mejora la claridad y permite pasar opciones específicas del formato.

**`option("header", "true")`**

Indica que el archivo contiene una fila de encabezados, que será usada como nombres de columnas.

**`option("inferSchema", "true")`**

Solicita a Spark que infiera los tipos de datos automáticamente. Útil en prototipos; en producción se recomienda schemas explícitos.

**`load(path)`**

Carga los datos desde un path físico (por ejemplo, un Volume de Databricks). No ejecuta inmediatamente, respeta la evaluación lazy.

---

### Escritura de datos

**`df.write`**

Interfaz de escritura de un DataFrame. Permite persistir datos en archivos o tablas.

**`format("delta")`**

Indica que el DataFrame se escribirá como Delta Lake, habilitando ACID, versionado y time travel.

**`mode("overwrite")` / `mode("append")`**

Controla el comportamiento ante datos existentes. `overwrite` reemplaza, `append` agrega nuevas filas.

**`saveAsTable("catalog.schema.table")`**

Crea o sobrescribe una tabla administrada por metastore (Unity Catalog). Abstrae el path físico y permite acceso vía SQL y notebooks.

---

### Delta Lake

**Delta Table**

Tabla basada en archivos Parquet más un transaction log (`_delta_log`). Garantiza consistencia transaccional y soporte de operaciones analíticas confiables.

---

## B. Transformaciones y Enriquecimiento (Silver Layer)

### Selección y proyección

**`select()`**

Permite elegir columnas específicas y definir expresiones sobre ellas. Es una transformación lazy.

---

### Funciones de columnas

**`withColumn(colName, expression)`**

Crea o reemplaza una columna aplicando una expresión. Es la forma estándar de transformar features en Spark.

**`col("column_name")`**

Referencia explícita a una columna del DataFrame, necesaria para expresiones seguras y legibles.

---

### Funciones matemáticas y financieras

**`lag()`**

Window function que permite acceder a valores de filas anteriores. Fundamental para cálculos de retornos financieros.

**`log()`**

Calcula logaritmo natural. Usado para retornos logarítmicos por su propiedad aditiva.

**`stddev()`**

Calcula desviación estándar poblacional o muestral. Utilizada para medir volatilidad.

---

### Window Functions

**`Window.partitionBy()`**

Define el grupo lógico sobre el que se aplican funciones analíticas (por activo, por ejemplo).

**`Window.orderBy()`**

Define el orden temporal dentro de cada partición. Esencial para series temporales.

Las window functions permiten cálculos que combinan agregación y granularidad fila a fila sin perder información.

---

### Limpieza de datos

**`dropna()`**

Elimina filas con valores nulos en columnas específicas o en cualquier columna.

**`filter()` / `where()`**

Filtra filas según una condición booleana. Ambas funciones son equivalentes.

---

## C. Agregaciones y Métricas de Negocio (Gold Layer)

### Agregaciones

**`groupBy()`**

Agrupa filas según una o más columnas para aplicar funciones agregadas.

**`agg()`**

Permite definir múltiples agregaciones en una sola operación (sum, avg, max, etc.).

---

### Métricas financieras

**Retorno acumulado**

Calculado mediante suma de retornos logarítmicos o producto de retornos simples.

**Volatilidad anualizada**

Escalada desde la desviación estándar diaria usando raíz de 252 (días de mercado).

**Sharpe Ratio**

Métrica riesgo-retorno: `(retorno esperado – tasa libre de riesgo) / volatilidad`.

---

### Persistencia Gold

Las tablas Gold se escriben también como Delta Tables, pero con semántica de consumo:

* Schemas estables
* Métricas precomputadas
* Listas para dashboards y SQL Analytics

---

## D. Machine Learning y Consumo (ML + BI)

### Feature Vector

**`VectorAssembler`**

Transforma múltiples columnas numéricas en un único vector de features requerido por Spark MLlib.

---

### Modelos MLlib

**`LinearRegression`**

Modelo supervisado para regresión. Usado como baseline interpretable en series financieras.

**`fit()`**

Entrena el modelo sobre un DataFrame etiquetado.

**`transform()`**

Aplica el modelo entrenado a nuevos datos, generando predicciones.

---

### MLflow

**MLflow Tracking**

Sistema integrado para registrar experimentos, parámetros, métricas y artefactos.

**`mlflow.start_run()`**

Inicia un experimento rastreable. Permite reproducibilidad y comparación.

---

### SQL y Dashboards

**Databricks SQL Warehouse**

Motor serverless optimizado para consultas SQL y dashboards. No expone Spark internals.

**Views**

Tablas virtuales que encapsulan lógica SQL sin duplicar datos. Ideales para consumo analítico.

**Dashboards**

Capa de visualización nativa. Consume directamente tablas Gold y Views, sin mover datos.

---

## Conceptos Transversales

### Lazy Evaluation

Spark no ejecuta transformaciones hasta que se llama a una acción. Esto permite optimización global del plan de ejecución.

### Catalyst Optimizer

Motor interno que reescribe y optimiza consultas DataFrame y SQL automáticamente.

### Unity Catalog

Sistema de gobernanza que gestiona permisos, lineage y metadatos a nivel catálogo/schema/table.

---
