# ⚽ Unión Analytics: Dashboard Interactivo de Rendimiento Histórico

Un análisis integral (End-to-End) del rendimiento deportivo del Club Atlético Unión de Santa Fe, abarcando competiciones oficiales desde 2015 hasta la actualidad.

**Herramientas y Tecnologías utilizadas:**
* **Python (Pandas, Cloudscraper):** Web scraping automatizado para extracción de datos deportivos en portales con seguridad anti-bot.
* **MySQL:** Limpieza, estandarización de entidades (rivales) y almacenamiento histórico (Data Warehouse).
* **Power BI & DAX:** Modelado matemático y visualización interactiva de KPIs.

**Proceso ETL (Extracción, Transformación y Carga):**
1. **Extracción:** Se desarrolló un script en Python para raspar el historial de partidos de la web. Se implementaron expresiones regulares (Regex) para aislar resultados finales puros, filtrando la "basura" HTML y los resultados parciales de entretiempo.
2. **Transformación:** Ingesta de datos crudos en MySQL. Se aplicaron sentencias `UPDATE` y filtros lógicos para normalizar los nombres de los equipos rivales (ej: unificar "CASL" y "San Lorenzo") y limpiar inconsistencias.
3. **Carga y Modelado:** Conexión directa a Power BI. Se construyó un modelo con medidas DAX robustas (`CALCULATE`, `COUNTROWS`, variables de división segura) para crear métricas dinámicas que respondan a los filtros del usuario.

**Insights Clave del Negocio (Deportivos):**
* **La Fortaleza Local:** Se demuestra estadísticamente una brecha de rendimiento gigante según la localía (51% de efectividad en casa vs. 35,23% de visitante).
* **Radiografía de Rivales:** Identificación visual rápida de los rivales más hostiles (ej. Defensa y Justicia, Lanús) frente a los "puntos seguros", aislando el ruido estadístico de cruces esporádicos (filtro de > 3 partidos jugados).
* **Evolución Cíclica:** El análisis histórico evidencia claramente los picos de rendimiento y los bajones deportivos, permitiendo cruzar los datos puros con los ciclos de los diferentes cuerpos técnicos.

**Archivos del Proyecto:**
En este repositorio se encuentra el script de extracción (Python), el código de transformación (SQL), el archivo original `.pbix` con el modelado de Power BI y un reporte escrito del proyecto.
