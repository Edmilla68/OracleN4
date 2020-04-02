DEFINE V_DATEINI = TO_DATE('2019-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');
DEFINE V_DATEFIN = TO_DATE('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');


    SELECT  
    TO_CHAR (ufv.time_in , 'YYYY-MM-DD HH24:MI') as "Time In",
    TO_CHAR (ufv.time_out , 'YYYY-MM-DD HH24:MI') as "Time Out",
    TRUNC(ufv.time_out)- TRUNC(ufv.time_in) as "Dwell",
    u.freight_kind AS "Frght Kind", 
    CASE U.CATEGORY  WHEN 'EXPRT' THEN 'Export' WHEN 'IMPRT' THEN 'Import'  END AS "Category", 
    u.id AS "Unit Nbr",
    SUBSTR(ret.nominal_length ,4,2) || CHR(39) AS "Type Length", --ret.nominal_length AS "Type Length",
    RET.ID as "Type ISO",
    CASE u.requires_power  WHEN 0 THEN 'false' ELSE 'true'  END AS "Reqs Power",  --u.requires_power AS "Reqs Power",
    RFS.ID AS "Line Op",
    UFV.ARRIVE_POS_LOCID AS "I/B Actual Visit",
    cv.ID AS "O/B Actual Visit",
    ufv.Last_Pos_Name AS "Position",
     initcap(trim(SUBSTR(ufv.transit_state ,5,length(transit_state)))) AS "T-State", --ufv.transit_state AS "T-State",
    u.flex_string10 AS "Deposito Temporal"
    FROM USRTOSN4P.inv_unit U
        LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV           ON U.GKEY = UFV.UNIT_GKEY
        LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE ON U.ID = RE.ID_FULL
        LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET  ON RET.GKEY =RE.EQTYP_GKEY    
        LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS          ON RFS.GKEY = U.LINE_OP 
        LEFT OUTER JOIN USRTOSN4P.argo_carrier_visit CV            ON (CV.GKEY = UFV.ACTUAL_OB_CV)
    WHERE U.CATEGORY = 'EXPRT' -- AND u.freight_kind = 'FCL'
    AND UFV.TIME_OUT >=  &V_DATEINI 
    AND UFV.TIME_OUT <=  &V_DATEFIN
    AND UFV.FCY_GKEY = 46182
    order by "Time Out";
   -- AND u.id = 'DRYU2801932'
    --order by u.id;
   -- EXCEPTION
