SELECT 

vsl.NAME as Nave,
vvd.IB_VYG  as Viaje,
evt.PLACED_TIME

FROM usrtosn4p.SRV_EVENT EVT
INNER JOIN usrtosn4p.SRV_EVENT_TYPES EVTT   
ON evt.EVENT_TYPE_GKEY = EVTT.GKEY  AND upper(EVTT.id) IN ('INGATE','UNIT_IN_GATE')

INNER JOIN usrtosn4p.INV_UNIT U ON EVT.APPLIED_TO_GKEY = U.GKEY
LEFT OUTER JOIN usrtosn4p.ORD_EQUIPMENT_ORDER_ITEMS         item        ON u.DEPART_ORDER_ITEM_GKEY = item.GKEY
                LEFT JOIN       usrtosn4p.INV_EQ_BASE_ORDER_ITEM            ibOrdItm    ON ibOrdItm.GKEY = item.GKEY
                LEFT JOIN       usrtosn4p.INV_EQ_BASE_ORDER                 ibOrd       ON ibOrd.GKEY = ibOrdItm.EQO_GKEY
                LEFT JOIN       usrtosn4p.ARGO_CARRIER_VISIT                ibCv        ON ibcv.GKEY = ibOrd.VESSEL_VISIT_GKEY
                LEFT JOIN       usrtosn4p.ARGO_VISIT_DETAILS                vd          ON ibCv.CVCVD_GKEY = vd.GKEY
                LEFT JOIN       usrtosn4p.VSL_VESSEL_VISIT_DETAILS          vvd         ON vd.GKEY = vvd.VVD_GKEY
                LEFT JOIN       usrtosn4p.VSL_VESSELS                       vsl         ON vvd.VESSEL_GKEY = vsl.GKEY
   


WHERE EVT.APPLIED_TO_CLASS = 'UNIT' 
AND EVT.placed_time >= TO_DATE('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
AND vsl.NAME IS NOT NULL
AND ROWNUM <= 100;


SELECT * 
FROM usrtosn4p.VSL_VESSELS
WHERE ROWNUM <= 100;


--LEFT JOIN       usrtosn4p.VSL_VESSEL_VISIT_DETAILS          vvd         ON vd.GKEY = vvd.VVD_GKEY
--LEFT JOIN       usrtosn4p.VSL_VESSELS                       vsl         ON vvd.VESSEL_GKEY = vsl.GKEY



--evt.PLACED_TIME