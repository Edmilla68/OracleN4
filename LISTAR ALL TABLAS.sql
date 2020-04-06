
SELECT owner, table_name 
FROM all_tables 
WHERE owner ='USRTOSN4P' 
AND table_name LIKE '%CARR%'
ORDER BY table_name;


--LISTAR TODAS LAS COLUMNAS
select * from all_tab_columns
where Owner = 'USRTOSN4P' and column_name like '%GRADE_ID%'
;






