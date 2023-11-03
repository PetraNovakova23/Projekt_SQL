CREATE VIEW v_gdp AS
SELECT *
FROM t_petra_novakova_project_sql_secondary_final tpnpssf
WHERE country = 'Czech Republic';

CREATE VIEW v_end_gdp AS
SELECT 
	GDP AS end_gdp,
	`year` +1 AS end_year,
	country 
FROM t_petra_novakova_project_sql_secondary_final tpnpssf 
WHERE country = 'Czech Republic';


SELECT 
	vay.payroll_year,
	(avg_wages_year - avg_wages_end_year)/avg_wages_end_year * 100 AS yearonyear_increase_wages,
	(avg_price_year - avg_price_end_year)/avg_price_end_year * 100 AS yearonyear_increase_price,
	(GDP - end_gdp)/end_gdp * 100 AS yearonyear_increase_gdp
FROM v_average_year vay 
JOIN v_average_end_year vaey 
	ON vaey.end_year = vay.payroll_year 
JOIN v_gdp vg 
	ON vg.`year` = vay.payroll_year 
JOIN v_end_gdp veg 
	ON veg.end_year = vay.payroll_year;

	
SELECT 
	(GDP - end_gdp)/end_gdp * 100 AS yearonyear_increase_gdp
FROM v_gdp vg 
JOIN v_end_gdp veg 
	ON veg.end_year = vg.`year` ;