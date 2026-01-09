# Portfolio Analytics en Databricks

## Descripción general

Este proyecto implementa un pipeline analítico completo en **Databricks** para el análisis de un portfolio financiero utilizando datos de mercado reales. El objetivo es demostrar, de punta a punta, cómo funciona la plataforma Databricks como un entorno unificado para *data engineering*, *analytics*, *machine learning* y *business intelligence*, sin salir del ecosistema y utilizando únicamente **Spark DataFrames, SQL y herramientas nativas**.

El proyecto fue diseñado con dos restricciones explícitas:

* Ser **realista y alineado con Databricks moderno** (Serverless / SQL Warehouses / Delta Lake / Unity Catalog)
* Poder ser **desarrollado y explicado en profundidad en un plazo corto (≈ 1–2 días)**

El resultado final es un **dashboard interactivo publicado en Databricks**, construido sobre tablas Delta limpias y modeladas.

👉 **Dashboard publicado**:
[https://dbc-e78805c9-ae33.cloud.databricks.com/dashboardsv3/01f0ed9878de1586bd10251efedfdc9d/published?o=1775234182689834&f_99c68feb%7E59837922=%257B%2522columns%2522%253A%255B%2522color%2522%252C%2522x%2522%255D%252C%2522rows%2522%253A%255B%255B%2522SPY%2522%252C%2522SPY%2522%255D%255D%257D](https://dbc-e78805c9-ae33.cloud.databricks.com/dashboardsv3/01f0ed9878de1586bd10251efedfdc9d/published?o=1775234182689834&f_99c68feb%7E59837922=%257B%2522columns%2522%253A%255B%2522color%2522%252C%2522x%2522%255D%252C%2522rows%2522%253A%255B%255B%2522SPY%2522%252C%2522SPY%2522%255D%255D%257D)

---

## Alcance funcional

El proyecto cubre:

* Ingesta de datos financieros históricos
* Persistencia en **Delta Lake**
* Limpieza y transformación de series temporales
* Cálculo de métricas financieras
* Modelado analítico orientado a consumo
* Visualización con **Databricks SQL Dashboards**
* Uso básico de **Machine Learning** con Spark ML

No se utilizan RDDs, APIs legacy ni herramientas externas de visualización.

---

## Arquitectura lógica

El diseño sigue la **Medallion Architecture**, estándar en Databricks:

```
Fuentes → Bronze → Silver → Gold → Dashboards
```

Cada capa cumple un rol específico y explícito.

---

## Capa Bronze – Ingesta

### Objetivo

Persistir los datos **sin lógica de negocio**, preservando trazabilidad y reproducibilidad.

### Datos

* Precios históricos diarios de activos financieros (ETFs, índices)
* Campos típicos: fecha, open, high, low, close, volume, adjusted close

### Características técnicas

* Ingesta vía PySpark
* Conversión explícita de tipos
* Escritura en **Delta Tables**
* Particionado lógico por activo

### Por qué Delta Lake

* Transacciones ACID
* Versionado (time travel)
* Consistencia para análisis financiero
* Integración nativa con Spark y SQL

Esta capa actúa como *raw data contract*.

---

## Capa Silver – Transformación

### Objetivo

Convertir datos crudos en datos analíticamente utilizables.

### Transformaciones aplicadas

* Normalización de fechas
* Control de valores nulos y gaps temporales
* Cálculo de:

  * Retornos diarios
  * Retornos logarítmicos
  * Volatilidad rolling

### Herramientas

* Spark DataFrames
* Window Functions
* Persistencia en Delta

Esta capa introduce **lógica financiera**, pero aún no métricas de negocio finales.

---

## Capa Gold – Métricas de negocio

### Objetivo

Exponer datos listos para consumo analítico y visualización.

### Métricas construidas

* Retorno acumulado por activo
* Volatilidad histórica
* Comparación contra benchmark
* Series normalizadas para visualización

### Diseño

* Tablas orientadas a consulta
* Bajo costo computacional
* Compatibles con Databricks SQL Warehouses

Esta capa es la única accedida por dashboards.

---

## Machine Learning

### Enfoque

El objetivo no es construir un modelo complejo, sino demostrar integración real con ML.

### Implementación

* Uso de Spark ML
* Feature engineering sobre retornos
* Modelo simple (clustering o regresión)
* Tracking con MLflow (si aplica)

Se muestra cómo Databricks permite entrenar modelos **directamente sobre las tablas Delta**, sin mover datos.

---

## Visualización y Dashboards

### Herramienta

* Databricks SQL Dashboards

### Características

* Consultas SQL sobre capa Gold
* Gráficos interactivos
* Filtros por activo
* Publicación nativa

No se utilizan herramientas externas como Power BI o Tableau.

---

## Consideraciones de plataforma

* No se utilizan RDDs (no disponibles en Serverless)
* Se prioriza Spark DataFrames y SQL
* No se accede a Spark UI
* Todo el proyecto es compatible con Databricks Free / Serverless

El diseño refleja **restricciones reales de producción**.

---

## Objetivos demostrados

Este proyecto demuestra capacidad para:

* Diseñar pipelines analíticos reales
* Entender arquitectura Lakehouse
* Trabajar con Databricks moderno
* Integrar analytics, ML y BI
* Entregar un artefacto final consumible

---

## Uso del proyecto

El proyecto puede utilizarse como:

* Entrega final de bootcamp
* Proyecto demostrativo en entrevistas
* Base para contenido educativo
* README de repositorio público

---

## Estado del proyecto

✔ Finalizado
✔ Dashboard publicado
✔ Pipeline reproducible
✔ Alineado con Databricks actual
