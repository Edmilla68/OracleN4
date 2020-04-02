SELECT u.id,
SRV.placed_time,
SRV.placed_by,
 (SELECT LISTAGG(NVL(prior_value,'(null)') ||' -> ' ||new_value, ', ') WITHIN GROUP (ORDER BY event_gkey)  "Changes"
   FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES WHERE event_gkey = SRV.GKEY) AS "CHANGES",
GD.BL_NBR,
argcv.ID AS "Ves Visit", 
CRG.QUANTITY AS "Qty",
CRG.custdff_flex_long_01 AS "Tx Nbr",
CRG.CUSTDFF_LOT_FLEX_STRING03 AS "LPN",
CRG.CUSTDFF_FLEX_DOUBLE_03 AS "Volumen",
CRG.CUSTDFF_FLEX_DOUBLE_02 AS "Peso Refrendo",
BL.CUSTDFF_BL_FLEX_STRING08 AS "Consolidador"

FROM USRTOSN4P.CRG_LOTS CRG
INNER JOIN USRTOSN4P.INV_UNIT U ON U.GOODS = CRG.GOODS_GKEY
INNER JOIN USRTOSN4P.SRV_EVENT SRV ON SRV.APPLIED_TO_GKEY = U.GKEY OR SRV.APPLIED_TO_GKEY = CRG.GKEY
INNER JOIN USRTOSN4P.SRV_EVENT_TYPES SRVT ON SRVT.GKEY = SRV.EVENT_TYPE_GKEY
LEFT JOIN USRTOSN4P.INV_GOODS GD            ON CRG.GOODS_GKEY = GD.GKEY
LEFT  JOIN USRTOSN4P.CRG_BL_GOODS CBD        ON CBD.GDS_GKEY = GD.GKEY
INNER  JOIN USRTOSN4P.CRG_BILLS_OF_LADING BL  ON CBD.BL_GKEY = BL.GKEY
INNER JOIN USRTOSN4P.argo_carrier_visit argcv ON BL.CV_GKEY = argcv.GKEY
WHERE SRV.placed_time >= TO_DATE('2019-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') ;

--WHERE CRG.ID LIKE '66764727-1-6'
--order by 2 desc;



/*
ULTIMOS CAMPOS AGREGADOS:
CUSTDFF_FLEX_DOUBLE_03      Volumen            Tabla crg_lots
CUSTDFF_FLEX_DOUBLE_02      Peso Refrendo      Tabla crg_lots
CUSTDFF_BL_FLEX_STRING08   Consolidador        Tabla crg_bills_of_lading
 

*/