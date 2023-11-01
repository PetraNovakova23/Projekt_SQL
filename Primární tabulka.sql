SELECT *
FROM czechia_payroll cp ;

SELECT *
FROM czechia_payroll_calculation cpc ;

SELECT *
FROM czechia_payroll_industry_branch cpib ;

SELECT *
FROM czechia_payroll_unit cpu ;

SELECT *
FROM czechia_payroll_value_type cpvt ;	

SELECT *
FROM czechia_price cp ;

SELECT *
FROM czechia_price_category cpc ;

SELECT *
FROM czechia_region cr ;


CREATE VIEW v_Petra_Novakova_projekt_SQL_czechia_price AS
SELECT 
	cp.id,
	cp.value,
	cp.category_code,
	cp.date_from,
	cp.date_to,
	cp.region_code,
	cpc.name AS category_name,
	cpc.price_value, 
	cpc.price_unit, 
	cr.name AS region_name
FROM czechia_price cp 
JOIN czechia_price_category cpc 	
	ON cpc.code = cp.category_code 
JOIN czechia_region cr 
	ON cr.code = cp.region_code ;

DROP VIEW v_petra_novakova_projekt_sql_czechia_price ;

CREATE VIEW v_Petra_Novakova_projekt_SQL_czechia_price AS
SELECT 
	cp.id AS id_price,
	cp.value AS price,
	cp.category_code,
	cp.date_from,
	cp.date_to,
	cp.region_code,
	cpc.name AS category_name,
	cpc.price_value, 
	cpc.price_unit, 
	cr.name AS region_name
FROM czechia_price cp 
JOIN czechia_price_category cpc 	
	ON cpc.code = cp.category_code 
JOIN czechia_region cr 
	ON cr.code = cp.region_code ;
	
SELECT *
FROM v_petra_novakova_projekt_sql_czechia_price vpnpscp ;


CREATE VIEW v_petra_novakova_projekt_sql_czechia_payroll AS
SELECT 
	cp.id,
	cp.value,
	cp.value_type_code,
	cp.unit_code,
	cp.calculation_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpc.name AS calculation_name,
	cpib.name AS industry_branch_name,
	cpu.name AS unit_name,
	cpvt.name AS value_type_name
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cpc.code = cp.calculation_code 
JOIN czechia_payroll_industry_branch cpib 
	ON cpib.code = cp.industry_branch_code 
JOIN czechia_payroll_unit cpu 
	ON cpu.code = cp.unit_code 
JOIN czechia_payroll_value_type cpvt 
	ON cpvt.code = cp.value_type_code ;

DROP VIEW v_petra_novakova_projekt_sql_czechia_payroll ;

CREATE VIEW v_petra_novakova_projekt_sql_czechia_payroll AS
SELECT 
	cp.id AS id_payroll,
	cp.value,
	cp.value_type_code,
	cp.unit_code,
	cp.calculation_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpc.name AS calculation_name,
	cpib.name AS industry_branch_name,
	cpu.name AS unit_name,
	cpvt.name AS value_type_name
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cpc.code = cp.calculation_code 
JOIN czechia_payroll_industry_branch cpib 
	ON cpib.code = cp.industry_branch_code 
JOIN czechia_payroll_unit cpu 
	ON cpu.code = cp.unit_code 
JOIN czechia_payroll_value_type cpvt 
	ON cpvt.code = cp.value_type_code ;

SELECT *
FROM v_petra_novakova_projekt_sql_czechia_payroll vpnpscp;


CREATE TABLE t_petra_novakova_projekt_sql_primary_final AS
SELECT *
FROM v_petra_novakova_projekt_sql_czechia_payroll vpnpscp 
JOIN v_petra_novakova_projekt_sql_czechia_price vpnpscp2 
	ON YEAR (vpnpscp2.date_from) = vpnpscp.payroll_year ;

DROP TABLE t_petra_novakova_projekt_sql_primary_final ;


CREATE TABLE t_petra_novakova_project_sql_primary_final AS
SELECT *
FROM v_petra_novakova_projekt_sql_czechia_payroll vpnpscp 
INNER JOIN v_petra_novakova_projekt_sql_czechia_price vpnpscp2 
	ON YEAR (vpnpscp2.date_from) = vpnpscp.payroll_year ;


SELECT *
FROM t_petra_novakova_project_sql_primary_final tpnpspf ;
