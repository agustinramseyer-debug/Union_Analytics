-- ==============================================================================
-- PROYECTO Club Analytics - Unión de Santa Fe (2015-2026)
-- DESCRIPCIÓN Limpieza de datos (ETL) y creación de vistas materializadas.
-- ==============================================================================

-- 1. LIMPIEZA DE DATOS (Data Cleaning)
-- Estandarización de nombres de oponentes para evitar duplicados en el reporte.
SET SQL_SAFE_UPDATES = 0;

UPDATE club_analytics.historial_union SET Oponente = 'San Lorenzo' WHERE Oponente = 'CASL';
UPDATE club_analytics.historial_union SET Oponente = 'Gimnasia LP' WHERE Oponente = 'GyEM';
UPDATE club_analytics.historial_union SET Oponente = 'Defensa y Justicia' WHERE Oponente = 'CSyD DyJ';
UPDATE club_analytics.historial_union SET Oponente = 'Ind. Rivadavia' WHERE Oponente = 'CSIR';
UPDATE club_analytics.historial_union SET Oponente = 'Instituto' WHERE Oponente = 'Instituto Córdo';
UPDATE club_analytics.historial_union SET Oponente = 'Deportivo Riestra' WHERE Oponente = 'Riesta';
UPDATE club_analytics.historial_union SET Oponente = 'Aldosivi' WHERE Oponente = 'CA Aldosivi';
UPDATE club_analytics.historial_union SET Oponente = 'Newells' WHERE Oponente LIKE 'Newell%';

SET SQL_SAFE_UPDATES = 1;

-- 2. VISTA RENDIMIENTO POR LOCALÍA (Pivot Table)
-- Transforma filas en columnas para medir la efectividad local vs. visitante.
CREATE OR REPLACE VIEW vw_rendimiento_localia AS
SELECT 
    Condicion,
    COUNT(*) AS Partidos_Totales,
    SUM(CASE WHEN Goles_Union > Goles_Rival THEN 1 ELSE 0 END) AS Victorias,
    SUM(CASE WHEN Goles_Union = Goles_Rival THEN 1 ELSE 0 END) AS Empates,
    SUM(CASE WHEN Goles_Union < Goles_Rival THEN 1 ELSE 0 END) AS Derrotas
FROM club_analytics.historial_union
GROUP BY Condicion;

-- 3. VISTA RADIOGRAFÍA DE RIVALES (Filtro de Relevancia)
-- Identifica "paternidades" filtrando cruces esporádicos (HAVING).
CREATE OR REPLACE VIEW vw_historial_rivales AS
SELECT 
    Oponente,
    COUNT(*) AS Partidos_Totales,
    SUM(CASE WHEN Goles_Union > Goles_Rival THEN 1 ELSE 0 END) AS Victorias,
    SUM(CASE WHEN Goles_Union = Goles_Rival THEN 1 ELSE 0 END) AS Empates,
    SUM(CASE WHEN Goles_Union < Goles_Rival THEN 1 ELSE 0 END) AS Derrotas
FROM club_analytics.historial_union
GROUP BY Oponente
HAVING Partidos_Totales  3
ORDER BY Partidos_Totales DESC;