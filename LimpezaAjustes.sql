/* Datetime: transformar esse campo em dois, sendo um o 'date' e outro o 'time' para construir filtros e visualizações agrupadas por horários, datas, e demais sazonalidades - mês, semana, etc.*/

/* Separando a coluna 'datetime' em duas - date e time*/
SELECT 
  DATETIME,
  DATE(DATETIME) AS date,  -- Extrai apenas a data
  TIME(DATETIME) AS time   -- Extrai apenas o tempo
FROM 
  `capital_share_bike_case` -- Dataset fictício para simular uso em GCP

/* Agrupando por mês, semana e horário */

SELECT 
  EXTRACT(YEAR FROM DATE(DATETIME)) AS year,
  EXTRACT(MONTH FROM DATE(DATETIME)) AS month,
  COUNT(*) AS total_records
FROM 
  `capital_share_bike_case` -- Dataset fictício para simular uso em GCP
GROUP BY 
  year, month
ORDER BY 
  year, month;

/* Agrupando por horário */

SELECT 
  EXTRACT(HOUR FROM TIME(DATETIME)) AS hour,
  COUNT(*) AS total_records
FROM 
  `capital_share_bike_case` -- Dataset fictício para simular uso em GCP
GROUP BY 
  hour
ORDER BY 
  hour;

/* Retirada do campo temp por um alter table */

ALTER TABLE `capital_share_bike_case`
DROP COLUMN Temperatura;

/* Substituindo valores numéricos por resultados nominais nas colunas de weather e season, por meio de um CASE WHEN */

SELECT 
  -- Usando CASE WHEN para transformar valores de weather pelos nomes atribuídos a cada valor
  CASE 
    WHEN weather = 1 THEN 'Ensolarado'
    WHEN weather = 2 THEN 'Nublado'
    WHEN weather = 3 THEN 'Chovendo'
    WHEN weather = 4 THEN 'Nevasca'
    ELSE 'Null'
  END AS weather_condition,

  -- Usando CASE WHEN para transformar valores de season em nomes de estações
  CASE 
    WHEN season = 1 THEN 'Inverno'
    WHEN season = 2 THEN 'Primavera'
    WHEN season = 3 THEN 'Verão'
    WHEN season = 4 THEN 'Outono'
    ELSE 'Null'
  END AS season_name
FROM 
  `capital_share_bike_case`;

