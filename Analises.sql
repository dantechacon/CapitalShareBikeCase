/* Identificando oportunidades nos dados fornecidos por meio de visualizações em SQL. */

/* Qual o impacto das condições do tempo na quantidade de aluguéis (mensalistas ou não) realizados por pessoas na cidade de Washington num dado período de tempo? */

SELECT 
weather_condition,  -- nos códigos de limpeza e ajustes dos campos da tabela, você verá que usei CASE WHEN para transformar o valor numérico de clima (weather) em nomes legíveis, adaptando o nome do campo para weather_condition,
AVG(casual) AS avg_casual_rentals, -- calculando a média de aluguéis não mensalistas por condição climática
AVG(registered) AS avg_registered_rentals, -- calculando a média de aluguéis mensalistas por condição climática
AVG(count) AS avg_total_rentals -- calculando a média total de aluguéis por condição climática
FROM capital_share_bike_case
GROUP BY weather_condition -- agrupando os resultados por condição climática
ORDER BY avg_total_rentals DESC; -- ordenando os resultados pela média total de aluguéis, em desc

/* Qual o impacto das estações do ano no aluguel de bikes na cidade? */

SELECT 
season_name, -- nos códigos de limpeza e ajustes dos campos da tabela, você verá que usei CASE WHEN para transformar o valor numérico da estação (season) em nomes padronizados, adaptando o nome do campo para 'season_name'
AVG(casual) AS avg_casual_rentals, -- calculando a média de aluguéis não mensalistas por estação
AVG(registered) AS avg_registered_rentals, -- calculando a média de aluguéis mensalistas por estação
AVG(count) AS avg_total_rentals -- calculando a média total de aluguéis (casual + registered) por estação
FROM capital_share_bike_case
GROUP BY season_name -- agrupando os resultados por estação
ORDER BY avg_total_rentals DESC;  -- ordenando os resultados pela média total de aluguéis, em desc

/* Será que as temperaturas afetam o comportamento de locação de bikes? */

SELECT 
ROUND(temp, 1) AS temperature, -- arredondando (round) o valor da temperatura para 1 casa decimal
AVG(casual) AS avg_casual_rentals, -- calculando a média de aluguéis não mensalistas por temperatura
AVG(registered) AS avg_registered_rentals,  -- calculando a média de aluguéis mensalistas por temperatura
AVG(count) AS avg_total_rentals -- calculando a média total de aluguéis (casual + registered) por temperatura
FROM capital_share_bike_case
GROUP BY temperature -- agrupando os resultados por temperature
ORDER BY avg_total_rentals DESC;  -- ordenando os resultados pela média total de aluguéis, em desc

/* Qual o impacto de altos ou baixos níveis de umidade e velocidade do vento na incidência do aluguel de bikes? */

SELECT 
ROUND(windspeed, 1) AS wind_speed, -- arredondando o valor da velocidade do vento para 1 casa decimal
ROUND(humidity, 1) AS humidity_level,  -- arredondando o valor da umidade para 1 casa decimal
AVG(casual) AS avg_casual_rentals,  -- calculando a média de aluguéis não mensalistas por velocidade do vento e umidade
AVG(registered) AS avg_registered_rentals, -- calculando a média de aluguéis mensalistas por velocidade do vento e umidade
AVG(count) AS avg_total_rentals  -- calculando a média total de aluguéis (casual + registered) por velocidade do vento e umidade
FROM capital_share_bike_case
GROUP BY wind_speed, humidity_level  -- agrupando resultados por velocidade do vento e umidade
ORDER BY avg_total_rentals DESC; -- ordenando os resultados pela média total de aluguéis, do maior para o menor (desc)

/* Em quais momentos do dia as pessoas tendem a alugar mais e menos as bikes fornecidas? */

SELECT 
EXTRACT(HOUR FROM time) AS hour_of_day, -- extraindo a hora do dia da coluna de tempo
AVG(casual) AS avg_casual_rentals, -- calculando a média de aluguéis não mensalistas por hora do dia
AVG(registered) AS avg_registered_rentals, -- calculando a média de aluguéis mensalistas por hora do dia
AVG(count) AS avg_total_rentals -- calculando a média total de aluguéis por hora do dia
FROM capital_share_bike_case
GROUP BY hour_of_day  -- agrupando os resultados pela hora do dia
ORDER BY avg_total_rentals DESC; -- ordenando os resultados pela média total de aluguéis, em desc

/* Em quais momentos os usuários mais utilizam as bikes? Dias úteis para trabalho, estudo, etc, ou em feriados? */

SELECT 
holiday,
workingday,
AVG(casual) AS avg_casual_rentals, -- calculando a média de aluguéis não mensalistas por feriado/dia útil
AVG(registered) AS avg_registered_rentals, -- calculando a média de aluguéis mensalistas por feriado/dia útil
AVG(count) AS avg_total_rentals -- calculando a média total de aluguéis por feriado/dia útil
FROM capital_share_bike_case
GROUP BY holiday, workingday -- agrupando por feriado e dia útil
ORDER BY avg_total_rentals DESC; -- ordenando os resultados pela média total de aluguéis, em desc

/* Qual o maior perfil de locadores: Mensalistas ou não mensalistas? E de que forma todas as condições mapeadas afetam o equilíbrio ou desequilíbrio entre as duas modalidades? */

SELECT 
AVG(casual) AS avg_casual_rentals, -- calculando a média de aluguéis não mensalistas em função de várias condições
AVG(registered) AS avg_registered_rentals, -- calculando a média de aluguéis registrados (mensalistas) em função de várias condições
AVG(count) AS avg_total_rentals,  -- calculando a média total de aluguéis
season_name,
weather_condition,
holiday,
workingday
FROM capital_share_bike_case
GROUP BY season_name, weather_condition, holiday, workingday -- agrupando os resultados por estação do ano, condição climática, feriado e dia útil
ORDER BY avg_total_rentals DESC;   -- ordenando os resultados pela média total de aluguéis, em desc

/* Disclaimer: podemos assumir os valores dos campos de holday, e workingday, como 1 sendo que sim, é um holiday ou workday, mas também é possível replicar as mesmas visualizações trazidas acima - que envolvem esses campos - assumindo que 0 é equivalente a true, e 1 é equivalente a false. Sendo o segundo caso, trago uma cláusula de WHERE em que ou é feriado ou dia útil */
SELECT 
-- Outros campos podem ser trazidos acima
holiday,
workingday
FROM capital_share_bike_case
WHERE holiday = 0 OR workingday = 0  -- puxando apenas os dias que são feriados OU não são dias úteis (workingday = 1), e é possível adaptar essa combinação da forma que desejar, sempre assumindo 0 como true e 1 como false
GROUP BY holiday, workingday -- agrupando por feriado e dia útil para ver as diferenças nas médias
ORDER BY avg_total_rentals DESC; -- ordenando pela média total de aluguéis



