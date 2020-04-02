
SELECT
U.ID AS "Nro Contenedor",
CASE RET.NOMINAL_LENGTH WHEN 'NOM40' THEN '40' ELSE
CASE RET.NOMINAL_LENGTH WHEN 'NOM45' THEN '45' ELSE
CASE RET.NOMINAL_LENGTH WHEN 'NOM20' THEN '20' ELSE
RET.NOMINAL_LENGTH
END END END  AS "TAMA�O",
CASE WHEN (RET.ID = '22P1' OR RET.ID = '42P3') THEN 'FR'    ELSE
CASE WHEN (RET.ID = 'L5G1' OR RET.ID = '45RH' OR RET.ID = '25R1') THEN 'RH'  ELSE
CASE WHEN (RET.ID = '42P1' OR RET.ID = '22P0') THEN 'FL'     ELSE
CASE WHEN (RET.ID = 'L5R1' OR RET.ID = '45RH' OR RET.ID = '25R1') THEN 'RH' ELSE
CASE WHEN (RET.ID = '22B0') THEN 'BL' ELSE
CASE WHEN (RET.ID = '45P3' ) THEN 'FH'   ELSE
CASE WHEN (RET.ID = 'L5G1' ) THEN 'HC' ELSE
CASE WHEN (RET.ID = '42V0' ) THEN 'HV' ELSE
CASE WHEN (RET.ID = '25U1' ) THEN 'OH' ELSE
CASE WHEN (RET.ID = '22P5') THEN 'OS' ELSE
CASE WHEN (RET.ID = '42R0') THEN 'R1' ELSE
CASE WHEN (RET.ID = '22R0') THEN 'RC' ELSE
CASE WHEN (RET.ID = '42R0') THEN 'RF' ELSE
CASE WHEN (RET.ID = '28U1') THEN 'TS'  ELSE
CASE WHEN (RET.ID = '22V0') THEN 'VH'  ELSE
CASE WHEN arq.ID = '20DR' THEN 'ST'  ELSE
CASE WHEN arq.ID = '20OT' THEN  'OT' ELSE
CASE WHEN arq.ID = '20RF' THEN 'RF'  ELSE
CASE WHEN arq.ID = '20TK' THEN 'TK'  ELSE
CASE WHEN arq.ID = '40DR' THEN 'ST' ELSE
CASE WHEN arq.ID = '40HC' THEN 'HC'  ELSE
CASE WHEN arq.ID = '40OT' THEN 'OT'  ELSE
CASE WHEN arq.ID = '40PL' THEN 'PL' ELSE
CASE WHEN arq.ID = '40RH' THEN 'RH' ELSE
CASE WHEN arq.ID = '40TK' THEN 'TK' ELSE
CASE WHEN arq.ID = 'L500' THEN 'TK' ELSE
CASE WHEN arq.ID = '2500' THEN 'HC' ELSE ARQ.ID
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END
END AS "TIPO",
EQBO.NBR AS "N�MERO DE BOOKING",
U.FLEX_STRING08 AS "OPERATION TYPE",
U.FREIGHT_KIND AS "CONDICION ORIGEN",
RE.TARE_KG AS "TARA",
ABS(RE.SAFE_KG - RE.TARE_KG) AS "PAYLOAD",
U.SEAL_NBR1 AS "SEAL#1",
U.SEAL_NBR2 AS "SEAL#2",
U.SEAL_NBR3 AS "SEAL#3",
U.SEAL_NBR4 AS "SEAL#4",
TO_CHAR(EV.PLACED_TIME,'DD/MM/YYYY') AS "FECHA ASIGNACION",
TO_CHAR(UF.TIME_OUT,'DD/MM/YYYY') AS "FECHA GATE OUT",
VS.NAME AS "NAVE",
VVD.OB_VYG AS "VIAJE",
TO_CHAR(VVD.PUBLISHED_ETA,'DD/MM/YYYY') AS "FECHA ETA",
RP.ID AS "ID PUERTO DESTINO FINAL",
EQBO.CUSTDFF_EDO_FLEX_STRING12 AS "PLEX",
EQBO.CUSTDFF_EDO_FLEX_STRING05 AS "CLIENTE",
EQBO.CUSTDFF_EDO_FLEX_STRING13 AS "OPERADOR LOGISTICO",
BSA.NAME AS "AGENTE DE ADUANAS",
EQBO.CUSTDFF_EDO_FLEX_STRING15 AS "MERCANCIA",
U.CUSTDFF_FLEX_STRING14 AS "BOOKING PRE ASIGNACI�N",
U.CUSTDFF_FLEX_STRING17 AS "Precinto2",
BS.ID AS "Linea Naviera"
FROM USRTOSN4P.INV_UNIT U
LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UF        ON U.GKEY = UF.UNIT_GKEY
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
WHERE
EV.EVENT_TYPE_GKEY = 179
AND EV.NOTE = U.ID
AND
EV.PLACED_TIME = (select MAX(PLACED_TIME) from USRTOSN4P.SRV_EVENT WHERE EVENT_TYPE_GKEY  = 179 AND APPLIED_TO_GKEY = EV.APPLIED_TO_GKEY AND NOTE = EV.NOTE) AND
U.COMPLEX_GKEY = 3575349411
AND VVD.PUBLISHED_ETA < TO_DATE('2020-04-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
AND VVD.PUBLISHED_ETA > TO_DATE('2019-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
AND BS.ID = 'HLC'