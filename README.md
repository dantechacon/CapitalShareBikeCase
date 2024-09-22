# Análise de Locações de Bicicletas - Washington (EUA)
Este repositório contém análises e queries SQL desenvolvidas para explorar os dados de locação de bicicletas em Washington D.C. A análise tem como foco entender como diferentes fatores impactam o volume de locações de bicicletas, tanto por usuários casuais quanto por mensalistas. O projeto também explora variáveis como clima, temperatura, velocidade do vento, dias da semana e horários do dia.

# Estrutura do Projeto
As queries desenvolvidas cobrem diferentes aspectos dos dados, como:

- Transformação de Colunas datetime:
Tem como objetivo separar a coluna datetime original em duas colunas distintas (date e time), facilitando a análise de padrões temporais como sazonalidade, dias da semana e horários de pico.
Código: O SQL inclui a função EXTRACT() para extrair e agrupar dados por dia, mês, ano, hora e outros períodos de interesse.

- Tratamento de Colunas Redundantes:
Tem como objetivo remover colunas duplicadas que representavam a mesma informação, como a coluna Temperatura e temp, para evitar redundância nos dados.
Código: A coluna foi removida utilizando ALTER TABLE ... DROP COLUMN.

- Mapeamento de Valores Numéricos:
Tem como objetivo substituir valores numéricos de colunas como season e weather por seus respectivos nomes, usando a função CASE WHEN. Isso melhora a legibilidade dos dados.
Exemplo: CASE WHEN weather = 1 THEN 'Ensolarado' ... foi aplicado para tornar gráficos e relatórios mais compreensíveis.

- Filtragem por Feriados e Dias Úteis:
Tem como objetivo criar filtros que extraem apenas os registros de dias que são feriados ou dias úteis.
Código: Foi utilizado WHERE holiday = 0 OR workingday = 0 para filtrar os dias relevantes para análise.

# Principais Insights
- Clima Ensolarado é o Favorito: O tempo ensolarado tem o maior número de locações, tanto por mensalistas quanto por usuários casuais.

- Temperaturas Agradáveis (20-29°C): Este é o intervalo preferido para locações, sendo mais comum durante a primavera e o outono.

- Dias Úteis vs. Finais de Semana: Os mensalistas preferem dias úteis, especialmente nos horários de pico (manhã e fim da tarde), enquanto os usuários casuais tendem a alugar mais nos finais de semana.

- Ventos Fortes e Temperaturas Baixas: Ventos fortes combinados com temperaturas baixas surpreendentemente incentivam mais locações entre mensalistas.

# Principais Variáveis que Impactam a Locação
1) Clima: O tempo ensolarado e nublado é o preferido.
2) Temperatura: Faixas entre 20-29°C e 10-19.99°C dominam.
3) Dias da Semana: Os dias úteis concentram a maioria das locações de mensalistas.
4) Vento: Ventos fortes, especialmente em temperaturas mais baixas, aumentam o número de locações, possivelmente por questões de conforto térmico e eficiência de locomoção.
