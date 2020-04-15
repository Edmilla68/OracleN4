--SELECT * FROM USRTOSN4P.ROAD_TRUCK_VISIT_DETAILS FETCH FIRST 100 ROWS ONLY



SELECT a.table_name, a.column_name, a.constraint_name, c.owner,
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
WHERE c.constraint_type = 'R'
   AND a.table_name like '%VSL_VESSELS%'
   ORDER BY R_TABLE_NAME;
--REF_EQUIPMENT

--ROAD_TRUCK_TRANSACTIONS



SELECT a.table_name, a.column_name, a.constraint_name, c.owner,
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
WHERE c.constraint_type = 'R'
   --AND a.table_name like '%INV_UNIT_FCY_VISIT%';
    AND c_pk.table_name like '%ORD_AR_EQUIPMENT_ORDER_ITEMS%';









select column_name, data_length, data_type from all_tab_columns 
where table_name = 'INV_UNIT'
AND COLUMN_NAME LIKE '%STRING08%';


select * FROM all_cons_columns 
where table_name like '%carg%';


select * from USER_TABLES;

select * from DBA_OBJECTS
where object_type = 'TABLE' 
AND OBJECT_NAME LIKE '%APPL%' 
AND OWNER = 'USRTOSN4P';



select table_name from all_tab_columns where column_name='EVENT_GKEY'  and owner='USRTOSN4P' order by table_name;

