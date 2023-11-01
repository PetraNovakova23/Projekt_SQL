CREATE VIEW v_average_wages AS
SELECT
	AVG(value) AS avg_wages,
	payroll_year 
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL 
GROUP BY payroll_year ;

CREATE VIEW v_average_end_wages AS
SELECT
	AVG(value) AS avg_end_wages,
	payroll_year + 1 AS end_year
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL 
GROUP BY end_year ;

SELECT 
	vap.payroll_year, 
	vaep.end_year, 
	(avg_wages - avg_end_wages)/avg_end_wages * 100 AS yearonyear_increase_wages,
	(avg_price - avg_end_price)/avg_end_price * 100 AS yearonyear_increase_price,
	CASE 
		WHEN (avg_price - avg_end_price)/avg_end_price * 100 - (avg_wages - avg_end_wages)/avg_end_wages * 100 >10 THEN 'up 10%'
		ELSE 'under 10%'
	END AS change_percent
FROM v_average_price vap 
JOIN v_average_end_price vaep  
	ON vaep.end_year = vap.payroll_year 
JOIN v_average_wages vaw 
	ON vaw.payroll_year = vap.payroll_year 
JOIN v_average_end_wages vaew 
	ON vaew.end_year = vap.payroll_year ;


	