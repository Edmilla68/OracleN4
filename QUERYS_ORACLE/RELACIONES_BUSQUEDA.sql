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
   AND a.table_name like '%INV_MOVE_EVENT%'
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
    AND c_pk.table_name like '%ROAD_TRUCK_TRANSACTIONS%';









select column_name, data_length, data_type from all_tab_columns 
where table_name = 'REF_EQUIPMENT';
INV_EQ_BASE_ORDER


select * FROM all_cons_columns 
where table_name like '%carg%';

Desc USRTOSN4P.srv_event

select * from USER_TABLES;

select * from DBA_OBJECTS
where object_type = 'TABLE' 
AND OBJECT_NAME LIKE '%APPL%' 
AND OWNER = 'USRTOSN4P';


select * from USRTOSN4P.CRG_BL_ITEM;
SP_HELP 'crg_lots'

--select * FROM USRTOSN4P.ROAD_TRUCK_VISIT_DETAILS

--select * FROM USRTOSN4P.road_truck_visit_stats FETCH FIRST 100 ROWS ONLY
--select FCY_GKEY FROM USRTOSN4P.INV_UNIT_FCY_VISIT   group by FCY_GKEY
select * FROM USRTOSN4P.argo_operator
select * FROM USRTOSN4P.argo_complex
select * FROM USRTOSN4P.ARGO_FACILITY;

--and data_type='NVARCHAR2'

select table_name from all_tab_columns where column_name='EVENT_GKEY'  and owner='USRTOSN4P' order by table_name;

SELECT * FROM USRTOSN4P.CRG_BL_ITEM
WHERE NBR like '%TLLU5016433%';
