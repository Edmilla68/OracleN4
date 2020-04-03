Select * from USRTOSN4P.inv_unit
where rownum <=10;



SELECT 
U.ID AS "EQUIPAMIENTO",
SUBSTR(ret.id,1,2)          AS "TIPO",
SUBSTR(ret.id,3,2)          AS "TAMAÑO",
re.tare_kg                  AS "TARA",
ret.safe_weight_kg - ret.tare_weight_kg AS "PMM",
'CLASE' AS CLASE,  --******************************************************************************************************************
REC.ID                      AS "Codigo Status Caja",
0       AS "IMPORTE PRESUPUESTO", --******************************************************************************************************************
TO_CHAR(ufv.TIME_IN,'YYYY-MM-DD HH24:MI') AS "F.Entrada Stock",  --"Time In",
RE.build_date as "FECHA FABRICACION"
--UFV.*

FROM USRTOSN4P.inv_unit U
LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE ON U.ID = RE.ID_FULL
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET  ON RET.GKEY =RE.EQTYP_GKEY
INNER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV     ON U.GKEY = ufv.UNIT_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_CONDITIONS REC ON REC.GKEY = U.CONDITION_GKEY
   
where REC.ID is not null;

--u.id = 'CPSU5168540';
   
WHERE rownum <=10;
