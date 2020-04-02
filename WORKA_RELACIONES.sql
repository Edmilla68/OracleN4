SELECT a.table_name, a.column_name, a.constraint_name, c.owner,
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
WHERE c.constraint_type = 'R'
   AND a.table_name ='INV_MOVE_EVENT';
   
   
   INV_UNIT_FCY_VISIT;
   
select * from USRTOSN4P.srv_event;
select * from USRTOSN4P.srv_event_types;
select * from USRTOSN4P.XPS_CHE;
select * from USRTOSN4P.SPATIAL_BINS;