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

DROP VIEW v_end_gdp ;

SELECT 
	vap.payroll_year,
	veg.end_year, 
	vg.GDP,
	(avg_wages - avg_end_wages)/avg_end_wages * 100 AS yearonyear_increase_wages,
	(avg_price - avg_end_price)/avg_end_price * 100 AS yearonyear_increase_price,
	(GDP - end_gdp)/end_gdp * 100 AS yearonyear_increase_gdp
FROM v_average_price vap  
JOIN v_average_end_price vaep 
	ON vaep.end_year = vap.payroll_year 
JOIN v_average_wages vaw 
	ON vaw.payroll_year = vap.payroll_year 
JOIN v_average_end_wages vaew 
	ON vaew.end_year = vap.payroll_year 
JOIN v_gdp vg 
	ON vg.`year` = vap.payroll_year 
JOIN v_end_gdp veg 
	ON veg.end_year = vap.payroll_year ;
	
SELECT 
	(GDP - end_gdp)/end_gdp * 100 AS yearonyear_increase_gdp
FROM v_gdp vg 
JOIN v_end_gdp veg 
	ON veg.end_year = vg.`year` ;