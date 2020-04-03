/*============== LINEA CMA.APL ==============================*/
SELECT DISTINCT 
--TO_CHAR(VVD.PUBLISHED_ETA,'DD/MM/YYYY') AS "FECHA ETA",
--U.ID AS "Nro Contenedor",
U.ID                                    AS "EQUIPAMIENTO",
SUBSTR(ret.id,1,2)                      AS "TIPO",
SUBSTR(ret.id,3,2)                      AS "TAMA�O",
re.tare_kg                              AS "TARA",
ret.safe_weight_kg - ret.tare_weight_kg AS "PMM",
egr.id                                  AS "CLASE",
REC.ID                                  AS "CODIGO STATUS CAJA",
TO_CHAR(ufv.TIME_IN,'YYYY-MM-DD HH24:MI') AS "F ENTRADA STOCK" ,
TRUNC(NVL(TRUNC(ufv.time_out),CURRENT_DATE) - TRUNC(ufv.time_in)) as "DIAS ENTRADA STOCK",
RE.build_date                               as "FECHA FABRICACION",
u.custdff_flex_string12                     AS "MOTIVO BLOQUEO",
EQBO.NBR 		                AS  "N�MERO DE BOOKING",
U.FLEX_STRING03                             as "COSTO/FECHA APROBACION",
u.CUSTDFF_FLEX_DATE03                       AS "FECHA FIN REPARACION",
U.remark                                    as "NOTA1",
u.custdff_flex_string11                     as "NOTA2",
BS.ID AS "LINEA"


FROM USRTOSN4P.INV_UNIT U
LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV        ON U.GKEY = UFV.UNIT_GKEY

LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED BS        ON U.LINE_OP = BS.GKEY  AND BS.ROLE = 'LINEOP'
INNER JOIN USRTOSN4P.INV_EQ_BASE_ORDER_ITEM EQBOI on U.DEPART_ORDER_ITEM_GKEY = EQBOI.GKEY
LEFT OUTER JOIN USRTOSN4P.INV_EQ_BASE_ORDER EQBO on EQBO.GKEY = EQBOI.EQO_GKEY AND EQBO.SUB_TYPE = 'EDO'
LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE             ON U.ID = RE.ID_FULL
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET           ON RET.GKEY =RE.EQTYP_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE ARQ           ON ARQ.GKEY = RET.ARCHETYPE
LEFT OUTER JOIN USRTOSN4P.ARGO_CARRIER_VISIT CV        ON CV.GKEY = EQBO.VESSEL_VISIT_GKEY
LEFT OUTER JOIN USRTOSN4P.VSL_VESSEL_VISIT_DETAILS VVD ON VVD.VVD_GKEY = CV.CVCVD_GKEY
LEFT OUTER JOIN USRTOSN4P.VSL_VESSELS VS               ON VS.GKEY = VVD.VESSEL_GKEY
LEFT OUTER JOIN USRTOSN4P.SRV_EVENT EV                 ON EV.APPLIED_TO_GKEY = EQBO.GKEY
LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED BSA       ON BSA.GKEY = EQBO.AGENT_GKEY AND BSA.ROLE = 'AGENT'
LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RP         ON RP.GKEY =  EQBO.CUSTDFF_EDO_FLEX_STRING20
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_CONDITIONS REC ON REC.GKEY = U.CONDITION_GKEY
LEFT OUTER JOIN USRTOSN4P.ORD_EQUIPMENT_ORDER_ITEMS     item        on u.DEPART_ORDER_ITEM_GKEY = item.GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_GRADES              egr         on egr.gkey = item.EQ_GRADE_GKEY
WHERE
U.COMPLEX_GKEY = 3575349411
--AND BS.ID='HLC'
AND VVD.PUBLISHED_ETA < TO_DATE('2020-04-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
AND VVD.PUBLISHED_ETA > TO_DATE('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
;


/*
SELECT
TO_CHAR(VVD.PUBLISHED_ETA,'DD/MM/YYYY') AS "FECHA ETA",
U.ID AS "Nro Contenedor",
U.ID                                    AS "EQUIPAMIENTO",
SUBSTR(ret.id,1,2)                      AS "TIPO",
SUBSTR(ret.id,3,2)                      AS "TAMA�O",
re.tare_kg                              AS "TARA",
ret.safe_weight_kg - ret.tare_weight_kg AS "PMM",
egr.id                                  AS "CLASE",
REC.ID                                  AS "CODIGO STATUS CAJA",
TO_CHAR(ufv.TIME_IN,'YYYY-MM-DD HH24:MI') AS "F ENTRADA STOCK" ,
TRUNC(NVL(TRUNC(ufv.time_out),CURRENT_DATE) - TRUNC(ufv.time_in)) as "DIAS ENTRADA STOCK",
RE.build_date                               as "FECHA FABRICACION",
u.custdff_flex_string12                     AS "MOTIVO BLOQUEO",
EQBO.NBR 		                AS  "N�MERO DE BOOKING",
U.FLEX_STRING03                             as "COSTO/FECHA APROBACION",
u.CUSTDFF_FLEX_DATE03                       AS "FECHA FIN REPARACION",
U.remark                                    as "NOTA1",
u.custdff_flex_string11                     as "NOTA2"
FROM            USRTOSN4P.INV_UNIT U
LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV                ON U.GKEY = UFV.UNIT_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED BS                 ON U.LINE_OP = BS.GKEY  AND BS.ROLE = 'LINEOP'
INNER JOIN      USRTOSN4P.INV_EQ_BASE_ORDER_ITEM EQBOI          ON U.DEPART_ORDER_ITEM_GKEY = EQBOI.GKEY
LEFT OUTER JOIN USRTOSN4P.INV_EQ_BASE_ORDER EQBO                ON EQBO.GKEY = EQBOI.EQO_GKEY AND EQBO.SUB_TYPE = 'EDO'
LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE                      ON U.ID = RE.ID_FULL
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET                    ON RET.GKEY =RE.EQTYP_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE ARQ                    ON ARQ.GKEY = RET.ARCHETYPE
LEFT OUTER JOIN USRTOSN4P.ARGO_CARRIER_VISIT CV                 ON CV.GKEY = EQBO.VESSEL_VISIT_GKEY
LEFT OUTER JOIN USRTOSN4P.VSL_VESSEL_VISIT_DETAILS VVD          ON VVD.VVD_GKEY = CV.CVCVD_GKEY
LEFT OUTER JOIN USRTOSN4P.VSL_VESSELS VS                        ON VS.GKEY = VVD.VESSEL_GKEY
LEFT OUTER JOIN USRTOSN4P.SRV_EVENT EV                          ON EV.APPLIED_TO_GKEY = EQBO.GKEY
LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED BSA                ON BSA.GKEY = EQBO.AGENT_GKEY AND BSA.ROLE = 'AGENT'
LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RP                  ON RP.GKEY =  EQBO.CUSTDFF_EDO_FLEX_STRING20
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_CONDITIONS REC              ON REC.GKEY = U.CONDITION_GKEY
LEFT OUTER JOIN USRTOSN4P.ORD_EQUIPMENT_ORDER_ITEMS     item    ON u.DEPART_ORDER_ITEM_GKEY = item.GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_GRADES              egr     ON egr.gkey = item.EQ_GRADE_GKEY
WHERE
U.COMPLEX_GKEY = 3575349411
AND BS.ID='HLC' 
AND VVD.PUBLISHED_ETA < TO_DATE('2020-04-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
AND VVD.PUBLISHED_ETA > TO_DATE('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') ;

*/








/*
AND VVD.PUBLISHED_ETA < TO_DATE($P{fechaETAFin},'YYYY/MM/DD HH24:MI')
AND VVD.PUBLISHED_ETA > TO_DATE($P{fechaETAInicio},'YYYY/MM/DD HH24:MI')

*/

/*

SELECT 

U.ID                                    AS "EQUIPAMIENTO",
SUBSTR(ret.id,1,2)                      AS "TIPO",
SUBSTR(ret.id,3,2)                      AS "TAMA�O",
re.tare_kg                              AS "TARA",
ret.safe_weight_kg - ret.tare_weight_kg AS "PMM",
egr.id                                  AS "CLASE",
REC.ID                                  AS "CODIGO STATUS CAJA",
TO_CHAR(ufv.TIME_IN,'YYYY-MM-DD HH24:MI') AS "F ENTRADA STOCK", 


TRUNC(NVL(TRUNC(ufv.time_out),CURRENT_DATE) - TRUNC(ufv.time_in)) as "DIAS ENTRADA STOCK",
RE.build_date                               as "FECHA FABRICACION",
u.custdff_flex_string12                     AS "MOTIVO BLOQUEO",
bkg.NBR                                     as "NUMEROBOOKING",
U.FLEX_STRING03                             as "COSTO/FECHA APROBACION",
u.CUSTDFF_FLEX_DATE03                       AS "FECHA FIN REPARACION",
U.remark                                    as "NOTA1",
u.custdff_flex_string11                     as "NOTA2"


FROM USRTOSN4P.inv_unit U
INNER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV     ON U.GKEY = ufv.UNIT_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE ON U.ID = RE.ID_FULL
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET  ON RET.GKEY =RE.EQTYP_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_CONDITIONS REC ON REC.GKEY = U.CONDITION_GKEY
LEFT OUTER JOIN         usrtosn4p.ORD_EQUIPMENT_ORDER_ITEMS     item        on u.DEPART_ORDER_ITEM_GKEY = item.GKEY
LEFT OUTER JOIN         usrtosn4p.INV_EQ_BASE_ORDER_ITEM        baseItem    on baseItem.GKEY = item.GKEY
LEFT OUTER JOIN         usrtosn4p.inv_eq_base_order             bkg         on baseItem.eqo_gkey = bkg.gkey
LEFT OUTER JOIN         usrtosn4p.REF_EQUIP_GRADES              egr         on egr.gkey = item.EQ_GRADE_GKEY 
WHERE
U.COMPLEX_GKEY = 3575349411
AND ufv.TIME_IN < TO_DATE($P{fechaETAFin},'YYYY/MM/DD HH24:MI')
AND ufv.TIME_IN > TO_DATE($P{fechaETAInicio},'YYYY/MM/DD HH24:MI');

*/