
CREATE VIEW v_average_price AS
SELECT 
	category_name,
	AVG (price) AS avg_price,
	payroll_year 
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
GROUP BY  	
	category_name,
	payroll_year;
			
CREATE VIEW v_average_end_price AS
SELECT
	category_name,
	AVG (price) AS avg_end_price,
	payroll_year + 1 AS end_year
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE price IS NOT NULL 
GROUP BY 
	category_name,
	end_year;

SELECT 
	vap.category_name,
	vap.payroll_year,
	vaep.end_year,
	(avg_price - avg_end_price)/avg_end_price * 100 AS yearonyear_increase
FROM v_average_price vap 
JOIN v_average_end_price vaep 
	ON vaep.category_name = vap.category_name 
	AND vaep.end_year = vap.payroll_year 
ORDER BY yearonyear_increase;

	