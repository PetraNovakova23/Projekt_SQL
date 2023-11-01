CREATE VIEW v_average_wages_2016 AS
SELECT 
	industry_branch_name,
	AVG(value) AS avg_value_2016
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE payroll_year = '2016' AND 
	value_type_code = 5958
GROUP BY industry_branch_name ;


CREATE VIEW v_average_wages_2017 AS
SELECT 
	industry_branch_name,
	AVG(value) AS avg_value_2017
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE payroll_year = '2017' AND 
	value_type_code = 5958
GROUP BY industry_branch_code ;


CREATE VIEW v_average_wages_2018 AS
SELECT 
	industry_branch_name,
	AVG(value) AS avg_value_2018
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE payroll_year = '2018' AND 
	value_type_code = 5958
GROUP BY industry_branch_name ;


CREATE VIEW v_average_wages AS
SELECT DISTINCT 
	vaw.industry_branch_name,
	vaw.avg_value_2016,
	vaw2.avg_value_2017,
	vaw3.avg_value_2018 
FROM v_average_wages_2016 vaw 
LEFT JOIN v_average_wages_2017 vaw2 
	ON vaw2.industry_branch_name = vaw.industry_branch_name 
LEFT JOIN v_average_wages_2018 vaw3 
	ON vaw3.industry_branch_name = vaw2.industry_branch_name ;

SELECT 
	*,
	CASE 
		WHEN avg_value_2017 > avg_value_2016 THEN 'yes'
		WHEN avg_value_2018 > avg_value_2017 THEN 'yes'
		ELSE 'no'
	END AS wage_growth
FROM v_average_wages vaw ;

SELECT 
	*,
	CASE 
		WHEN avg_value_2017 > avg_value_2016 THEN 'yes'
		WHEN avg_value_2018 > avg_value_2017 THEN 'yes'
		ELSE 'no'
	END AS wage_growth
FROM (SELECT DISTINCT 
	vaw.industry_branch_name,
	vaw.avg_value_2016,
	vaw2.avg_value_2017,
	vaw3.avg_value_2018 
FROM v_average_wages_2016 vaw 
LEFT JOIN v_average_wages_2017 vaw2 
	ON vaw2.industry_branch_name = vaw.industry_branch_name 
LEFT JOIN v_average_wages_2018 vaw3 
	ON vaw3.industry_branch_name = vaw2.industry_branch_name) AS average_values;

	