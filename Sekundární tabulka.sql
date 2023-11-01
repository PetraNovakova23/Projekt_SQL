SELECT *
FROM countries c ;

SELECT *
FROM economies e ;




CREATE VIEW v_economies AS
SELECT 
	country,
	`year`,
	GDP,
	population,
	gini
FROM economies e 
WHERE year BETWEEN 2006 AND 2018;


CREATE VIEW v_countries AS
SELECT 
	country,
	continent
FROM countries c 
WHERE continent = 'Europe';


CREATE TABLE t_petra_novakova_project_sql_secondary_final AS
SELECT 
	ve.country,
	ve.`year`,
	ve.GDP,
	ve.population,
	ve.gini,
	vc.continent 
FROM v_economies ve 
LEFT JOIN v_countries vc 
	ON vc.country = ve.country ;
	
SELECT *
FROM t_petra_novakova_project_sql_secondary_final tpnpssf ;