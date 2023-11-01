SELECT 
	category_name,
	AVG(price) AS avg_price,
	AVG(value) AS avg_wages,
	AVG(value)/AVG(price) AS price_vs_wage,
	payroll_year 
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE category_name IN ('Chléb konzumní kmínový','Mléko polotučné pasterované') AND 
	payroll_year IN ('2006','2018') AND 
	value_type_code = 5958
GROUP BY 
	category_name,
	payroll_year 
ORDER BY payroll_year ;