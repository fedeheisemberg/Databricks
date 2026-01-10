# Portfolio Analytics en Databricks

Pipeline analítico integral para el análisis de activos financieros. El proyecto demuestra la capacidad de la plataforma como un entorno unificado para *Data Engineering, ML y BI*, operando exclusivamente sobre **Delta Lake y Spark SQL/DataFrames**.

👉 **[Ver Dashboard Interactivo](https://dbc-e78805c9-ae33.cloud.databricks.com/dashboardsv3/01f0ed9878de1586bd10251efedfdc9d/published?o=1775234182689834&f_99c68feb%7E59837922=%257B%2522columns%2522%253A%255B%2522color%2522%252C%2522x%2522%255D%252C%2522rows%2522%253A%255B%255B%2522SPY%2522%252C%2522SPY%2522%255D%255D%257D)**

---

##  Arquitectura de Datos (Medallion)

El diseño sigue el estándar industrial de **Lakehouse Architecture**, garantizando trazabilidad y eficiencia:

| Capa | Proceso | Objetivo |
| --- | --- | --- |
| **Bronze** | Ingesta PySpark | Persistencia de datos crudos (OHLCV) con transacciones ACID y Time Travel. |
| **Silver** | Transformación | Limpieza, normalización y cálculo de retornos logarítmicos y volatilidad (Window Functions). |
| **Gold** | Agregación | Tablas de alta performance para negocio: retornos acumulados y benchmarks. |

---

##  Stack Tecnológico y Principios

* **Motor:** Apache Spark (DataFrames API) y Spark SQL.
* **Almacenamiento:** Delta Lake para consistencia y versionado de datos.
* **Gobernanza:** Unity Catalog (orientado a Serverless).
* **Visualización:** Databricks SQL Dashboards (nativo).
* **ML:** Spark ML para feature engineering y clustering de activos directamente sobre el Lakehouse.

> **Restricción de Diseño:** El proyecto se alinea con estándares de producción modernos: sin APIs legacy (RDDs), uso intensivo de SQL Warehouses y compatibilidad total con entornos Serverless.

---

##  Funcionalidades Clave

1. **Ingesta de Series Temporales:** Procesamiento de datos históricos de mercado con esquemas validados.
2. **Ingeniería de Características Financieras:** Cálculo distribuido de métricas de riesgo y rendimiento.
3. **Integración MLflow:** Entrenamiento de modelos sin movimiento de datos (Data-Centric AI).
4. **Analytics Hub:** Dashboard interactivo con filtros dinámicos por activo y comparación de series normalizadas.

---

##  Objetivos Demostrados

* Diseño de pipelines de datos escalables bajo arquitectura **Lakehouse**.
* Dominio de **Spark SQL** para análisis cuantitativo complejo.
* Capacidad de entrega de artefactos finales (Dashboards) sin dependencias externas.
* Gestión de ciclo de vida de datos en entornos **Databricks Cloud**.

---


