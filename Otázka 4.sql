CREATE VIEW v_average_year AS
SELECT 
	AVG(value) AS avg_wages_year,
    AVG(price) AS avg_price_year,
    payroll_year  
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE price IS NOT NULL 
    AND value IS NOT NULL
GROUP BY payroll_year ;

CREATE VIEW v_average_end_year AS
SELECT 
	AVG(value) AS avg_wages_end_year,
	AVG(price) AS avg_price_end_year,
	payroll_year + 1 AS end_year
FROM t_petra_novakova_project_sql_primary_final tpnpspf 
WHERE price IS NOT NULL AND 
	value IS NOT NULL 
GROUP BY end_year;

SELECT 
	vay.payroll_year, 
	vaey.end_year, 
	(avg_wages_year - avg_wages_end_year)/avg_wages_end_year * 100 AS yearonyear_increase_wages,
	(avg_price_year - avg_price_end_year)/avg_price_end_year * 100 AS yearonyear_increase_price,
	CASE 
		WHEN (avg_price_year - avg_Price_end_year)/avg_price_end_year * 100 - (avg_wages_year - avg_wages_end_year)/avg_wages_end_year * 100 >10 THEN 'up 10%'
		ELSE 'under 10%'
	END AS change_percent
FROM v_average_year vay 
JOIN v_average_end_year vaey 
	ON vaey.end_year = vay.payroll_year;
	