Select * from USRTOSN4P.inv_unit
where rownum <=10;



SELECT 
U.ID AS "EQUIPAMIENTO",
SUBSTR(ret.id,1,2)          AS "TIPO",
SUBSTR(ret.id,3,2)          AS "TAMAÑO",
re.tare_kg      AS "TARE",
ret.safe_weight_kg - ret.tare_weight_kg AS "PMM",
U.*

FROM USRTOSN4P.inv_unit U

LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE ON U.ID = RE.ID_FULL
    LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET  ON RET.GKEY =RE.EQTYP_GKEY


WHERE rownum <=10;
