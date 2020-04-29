SELECT
ID,
PLACED_TIME,
PLACED_BY,
LISTAGG(NVL(PRIORVALUE,'(null)') ||' -> ' ||NEWVALUE, ', ') WITHIN GROUP (ORDER BY PRIORVALUE)  as "CHANGES",
"BL NBR",
"VES VISIT", 
"QTY",
"TX NBR",
"LPN",
"VOLUMEN",
"PESO REFRENDO",
"CONSOLIDADOR"
FROM
(
SELECT DISTINCT
U.ID                                AS ID,
SRV.PLACED_TIME                     AS PLACED_TIME,
SRV.PLACED_BY                       AS PLACED_BY,
GD.BL_NBR                           AS "BL NBR",
argcv.ID                            AS "VES VISIT", 
CRG.QUANTITY                        AS "QTY",
CRG.custdff_flex_long_01            AS "TX NBR",
CRG.CUSTDFF_LOT_FLEX_STRING03       AS "LPN",
CRG.CUSTDFF_FLEX_DOUBLE_03          AS "VOLUMEN",
CRG.CUSTDFF_FLEX_DOUBLE_02          AS "PESO REFRENDO",
BL.CUSTDFF_BL_FLEX_STRING08         AS "CONSOLIDADOR",
SRV.GKEY                            AS "SRV_GKEY",
efch.prior_value                    AS "PRIORVALUE",
efch.new_value                      AS "NEWVALUE"
FROM        USRTOSN4P.CRG_LOTS CRG
INNER JOIN  USRTOSN4P.INV_UNIT U                ON U.GOODS = CRG.GOODS_GKEY
INNER JOIN  USRTOSN4P.SRV_EVENT SRV             ON SRV.APPLIED_TO_GKEY = U.GKEY OR SRV.APPLIED_TO_GKEY = CRG.GKEY
INNER JOIN  USRTOSN4P.SRV_EVENT_TYPES SRVT      ON SRVT.GKEY = SRV.EVENT_TYPE_GKEY
LEFT  JOIN  USRTOSN4P.INV_GOODS GD              ON CRG.GOODS_GKEY = GD.GKEY
LEFT  JOIN  USRTOSN4P.CRG_BL_GOODS CBD          ON CBD.GDS_GKEY = GD.GKEY
INNER JOIN  USRTOSN4P.CRG_BILLS_OF_LADING BL    ON CBD.BL_GKEY = BL.GKEY
INNER JOIN  USRTOSN4P.ARGO_CARRIER_VISIT ARGCV  ON BL.CV_GKEY = ARGCV .GKEY
LEFT OUTER JOIN USRTOSN4P.SRV_EVENT_FIELD_CHANGES EFCH on efch.event_gkey = SRV.GKEY
WHERE 
SRV.PLACED_TIME >= TO_DATE('2019-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
)ZZZ

GROUP BY 

ID,
PLACED_TIME,
PLACED_BY,
"BL NBR",
"VES VISIT", 
"QTY",
"TX NBR",
"LPN",
"VOLUMEN",
"PESO REFRENDO",
"CONSOLIDADOR",
"SRV_GKEY",
PRIORVALUE,
NEWVALUE
;




/*
SELECT
ID,
PLACED_TIME,
PLACED_BY,
(
 
    SELECT LISTAGG(NVL(prior_value,'(null)') ||' -> ' ||new_value, ', ') WITHIN GROUP (ORDER BY prior_value)  as "Changes"
    FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES WHERE event_gkey = SRV_GKEY
   
   
                )    AS "CHANGES0",


LISTAGG(NVL(PRIORVALUE,'(null)') ||' -> ' ||NEWVALUE, ', ') WITHIN GROUP (ORDER BY PRIORVALUE)  as "Changes",
LISTAGG(PRIORVALUE, ', ') WITHIN GROUP (ORDER BY PRIORVALUE)  AS "Changes2",


"BL NBR",
"VES VISIT", 
"QTY",
"TX NBR",
"LPN",
"VOLUMEN",
"PESO REFRENDO",
"CONSOLIDADOR"
FROM
(
SELECT DISTINCT
U.ID                                AS ID,
SRV.PLACED_TIME                     AS PLACED_TIME,
SRV.PLACED_BY                       AS PLACED_BY,
GD.BL_NBR                           AS "BL NBR",
argcv.ID                            AS "VES VISIT", 
CRG.QUANTITY                        AS "QTY",
CRG.custdff_flex_long_01            AS "TX NBR",
CRG.CUSTDFF_LOT_FLEX_STRING03       AS "LPN",
CRG.CUSTDFF_FLEX_DOUBLE_03          AS "VOLUMEN",
CRG.CUSTDFF_FLEX_DOUBLE_02          AS "PESO REFRENDO",
BL.CUSTDFF_BL_FLEX_STRING08         AS "CONSOLIDADOR",
SRV.GKEY                            AS "SRV_GKEY",
efch.prior_value                    AS "PRIORVALUE",
efch.new_value                      AS "NEWVALUE"
FROM        USRTOSN4P.CRG_LOTS CRG
INNER JOIN  USRTOSN4P.INV_UNIT U                ON U.GOODS = CRG.GOODS_GKEY
INNER JOIN  USRTOSN4P.SRV_EVENT SRV             ON SRV.APPLIED_TO_GKEY = U.GKEY OR SRV.APPLIED_TO_GKEY = CRG.GKEY
INNER JOIN  USRTOSN4P.SRV_EVENT_TYPES SRVT      ON SRVT.GKEY = SRV.EVENT_TYPE_GKEY
LEFT  JOIN  USRTOSN4P.INV_GOODS GD              ON CRG.GOODS_GKEY = GD.GKEY
LEFT  JOIN  USRTOSN4P.CRG_BL_GOODS CBD          ON CBD.GDS_GKEY = GD.GKEY
INNER JOIN  USRTOSN4P.CRG_BILLS_OF_LADING BL    ON CBD.BL_GKEY = BL.GKEY
INNER JOIN  USRTOSN4P.ARGO_CARRIER_VISIT ARGCV  ON BL.CV_GKEY = ARGCV .GKEY
LEFT OUTER JOIN USRTOSN4P.SRV_EVENT_FIELD_CHANGES EFCH on efch.event_gkey = SRV.GKEY
WHERE 
SRV.PLACED_TIME >= TO_DATE('2019-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
)ZZZ

GROUP BY 

ID,
PLACED_TIME,
PLACED_BY,
"BL NBR",
"VES VISIT", 
"QTY",
"TX NBR",
"LPN",
"VOLUMEN",
"PESO REFRENDO",
"CONSOLIDADOR",
"SRV_GKEY",
PRIORVALUE,
NEWVALUE
;
*/