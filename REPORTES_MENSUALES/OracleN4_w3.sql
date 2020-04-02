select 
TO_CHAR (MVE.T_PUT , 'YYYY-MM-DD HH24:MI') AS "Time Completed", 
TO_CHAR (mve.t_carry_fetch_ready , 'YYYY-MM-DD HH24:MI') AS "Time Carry Che Ready",
evnttype.ID AS "Event ID",
'Yard ' || initcap(trim(SUBSTR(evnttype.ID ,11,length(evnttype.ID)))) AS "Move Kind",  --evnttype.ID AS "Move Kind"
CASE U.CATEGORY  WHEN 'EXPRT' THEN 'Export' WHEN 'IMPRT' THEN 'Import' WHEN 'TRSHP' THEN 'TransShip' WHEN 'THRGH' THEN 'FALTACONSULTAR' WHEN 'STRGE' THEN 'FALTACONSULTAR' END AS "Unit Category",  --U.CATEGORY AS "Unit Category",
U.id    AS "Unit Nbr",
RFS.ID AS "Line Op",
MVE.CHE_FETCH_LOGIN_NAME AS "Fetch CHE Login Name",
MVE.CHE_PUT_LOGIN_NAME AS "Put CHE Login Name",
MVE.REHANDLE_COUNT AS "Rehandle Count",
u.flex_string10 AS "Unit Deposito Temporal",
TRUNC(NVL(TRUNC(ufv.time_out),CURRENT_DATE) - TRUNC(ufv.time_in)) as "Unit Dwell",
CHEF.FULL_NAME AS "Fetch CHE Name",
CHEC.FULL_NAME AS "Carry CHE Name",
CHEP.FULL_NAME AS "Put CHE Name",


GD.HAZARDOUS AS "Unit Hazardous?",
U.REQUIRES_POWER AS "Unit Reqs Power", 
U.IS_OOG AS "Unit Is OOG" 

--TRUNC(ufv.time_in) - 0 as "DwellINVERTIDO",
--ufv.time_out,
--ufv.time_IN

--CheFetchLoginName
--mve.*, 
--u.*, 
--ufv.* 
from USRTOSN4P.inv_move_event mve
  INNER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV           ON UFV.GKEY = mve.UFV_GKEY
    INNER JOIN USRTOSN4P.inv_unit U           ON U.GKEY = UFV.UNIT_GKEY
    INNER JOIN USRTOSN4P.SRV_EVENT SRV        ON MVE.MVE_GKEY = SRV.GKEY
    INNER JOIN USRTOSN4P.SRV_EVENT_TYPES evnttype ON evnttype.GKEY = SRV.EVENT_TYPE_GKEY
    LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS          ON RFS.GKEY = U.LINE_OP 
 
    LEFT OUTER JOIN USRTOSN4P.XPS_CHE CHEF       ON CHEF.GKEY = MVE.CHE_FETCH
    LEFT OUTER JOIN USRTOSN4P.XPS_CHE CHEC       ON CHEC.GKEY = MVE.CHE_CARRY
    LEFT OUTER JOIN USRTOSN4P.XPS_CHE CHEP       ON CHEP.GKEY = MVE.CHE_PUT
    
    LEFT OUTER JOIN USRTOSN4P.INV_GOODS GD                 ON U.GOODS = GD.GKEY
    
WHERE evnttype.ID IN ('UNIT_YARD_MOVE','UNIT_YARD_SHIFT')
    AND MVE.T_PUT >=  TO_DATE('2018-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
    AND MVE.T_PUT <=  TO_DATE('2018-12-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS')   --MVE.T_PUT between '07/10/2019' and '08/10/2019'
 --AND U.ID = 'ALHU0000334'    
AND UFV.FCY_GKEY = 46182
ORDER BY U.ID;
  
 
  --mveCheFetchLoginName
    
  -- AND U.ID = 'ALHU0000334'    
/*    
select  UFV.time_complete, U.id,  mve.*
from USRTOSN4P.inv_move_event mve
  LEFT JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV           ON UFV.GKEY = mve.UFV_GKEY
  LEFT OUTER JOIN USRTOSN4P.inv_unit U           ON U.GKEY = UFV.UNIT_GKEY
WHERE UFV.time_complete >  TO_DATE('2019-10-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  AND UFV.time_complete <  TO_DATE('2019-10-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  --AND U.ID = 'QNNU1240314'
 -- AND MVE.MOVE_KIND = 'YARD'
  AND UFV.FCY_GKEY = 46182
  ORDER BY U.ID;
    
    
    */