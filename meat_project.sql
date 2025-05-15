USE meat_project;

-- cargamos las tablas desde los CSV a traves de "table data import wizard"

-- countries clave primaria
ALTER TABLE countries
ADD PRIMARY KEY (country_id);

-- claves primarias a las tablas de datos
ALTER TABLE meat_consumption_cleaned
ADD COLUMN consumption_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE gdp_cleaned
ADD COLUMN gdp_id INT AUTO_INCREMENT PRIMARY KEY;

-- claves foráneas
ALTER TABLE gdp_cleaned
ADD CONSTRAINT fk_country_gdp
FOREIGN KEY (country_id)
REFERENCES countries(country_id);

ALTER TABLE meat_consumption_cleaned
ADD CONSTRAINT fk_country_meat
FOREIGN KEY (country_id)
REFERENCES countries(country_id);

-- modificar nombre columna continente
ALTER TABLE gdp_cleaned
CHANGE `Ð¡ontinent` `Continent` VARCHAR(50);

-- consulta base relacion PIB y consumo total de carne (año 2019)
	-- sumamos todas las carnes y join entre GDO y consumo total
    -- año 19, mas representativo antes del covid
-- primero ordenamos por los paises que tienen mas GDP-PPP
SELECT 
    c.Entity AS country,
    g.`GDP per capita, PPP (constant 2017 international $)` AS gdp_per_capita,
    ROUND(
        mc.Poultry + mc.Beef + mc.`Sheep and goat` + mc.Pork + mc.`Other meats` + mc.`Fish and seafood`, 2
    ) AS total_meat_consumption
FROM 
    gdp_cleaned g
JOIN 
    meat_consumption_cleaned mc ON g.country_id = mc.country_id AND g.year = mc.year
JOIN 
    countries c ON g.country_id = c.country_id
WHERE 
    g.year = 2019
ORDER BY 
    gdp_per_capita DESC;

-- ahora por los que mas carne consumen
SELECT 
    c.Entity AS country,
    g.`GDP per capita, PPP (constant 2017 international $)` AS gdp_per_capita,
    ROUND(
        mc.Poultry + mc.Beef + mc.`Sheep and goat` + mc.Pork + mc.`Other meats` + mc.`Fish and seafood`, 2
    ) AS total_meat_consumption
FROM 
    gdp_cleaned g
JOIN 
    meat_consumption_cleaned mc ON g.country_id = mc.country_id AND g.year = mc.year
JOIN 
    countries c ON g.country_id = c.country_id
WHERE 
    g.year = 2019
ORDER BY 
    total_meat_consumption DESC;
    
-- identificar paises con mas consumo de carne roja (vaca y cerdo) y los que mas carne sostenible (ave y seafood)
SELECT 
    c.Entity AS country,
    g.`GDP per capita, PPP (constant 2017 international $)` AS gdp_per_capita,
    mc.Beef,
    mc.Pork,
    mc.Poultry,
    mc.`Fish and seafood`
FROM 
    gdp_cleaned g
JOIN 
    meat_consumption_cleaned mc ON g.country_id = mc.country_id AND g.year = mc.year
JOIN 
    countries c ON g.country_id = c.country_id
WHERE 
    g.year = 2019
ORDER BY 
    mc.Beef + mc.Pork DESC;

-- la media por continente del consumo de cada carne
SELECT 
    g.Continent AS continent,
    ROUND(AVG(mc.Beef), 2) AS avg_beef,
    ROUND(AVG(mc.Pork), 2) AS avg_pork,
    ROUND(AVG(mc.Poultry), 2) AS avg_poultry,
    ROUND(AVG(mc.`Sheep and goat`), 2) AS avg_sheep_goat,
    ROUND(AVG(mc.`Fish and seafood`), 2) AS avg_fish
FROM 
    gdp_cleaned g
JOIN 
    meat_consumption_cleaned mc ON g.country_id = mc.country_id AND g.Year = mc.Year
WHERE 
    g.Year = 2019
GROUP BY 
    g.Continent;
    
-- analizamos la evolucion en España a lo largo del tiempo
SELECT 
    mc.Year,
    mc.Beef,
    mc.Pork,
    mc.Poultry,
    mc.`Fish and seafood`
FROM 
    meat_consumption_cleaned mc
JOIN 
    countries c ON mc.country_id = c.country_id
WHERE 
    c.Entity = 'Spain'
ORDER BY 
    mc.Year;