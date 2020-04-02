
SELECT owner, table_name 
FROM all_tables 
WHERE owner ='USRTOSN4P' 
AND table_name LIKE '%CARR%'
ORDER BY table_name;



