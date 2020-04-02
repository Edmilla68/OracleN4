SELECT    *  
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
WHERE c.constraint_type = 'R'
   AND a.table_name ='CRG_BILLS_OF_LADING';


SELECT * FROM all_constraints WHERE constraint_type = 'R'    AND table_name ='CRG_BILLS_OF_LADING';

SELECT * FROM all_cons_columns WHERE table_name ='CRG_BILLS_OF_LADING' AND ROWNUM <= 10;



