SELECT
vsl.NAME as Nave,
vvd.IB_VYG  as Viaje,
ufv.TRANSIT_STATE               AS EstadoTransito,
CAST(u.gkey as varchar2(30))    AS IdContenedor,
u.Id                            AS NumeroContenedor,
u.Category                      AS Categoria,
u.FLEX_STRING08                 AS TipoEntrada,
TO_CHAR(SYSDATE, 'DD-MM-YYYY')  AS FechaFabricacionStr,
(SELECT evt.PLACED_TIME FROM usrtosn4p.SRV_EVENT evt
        INNER JOIN usrtosn4p.SRV_EVENT_TYPES et
        ON evt.EVENT_TYPE_GKEY = et.GKEY  AND upper(et.id) IN ('INGATE','UNIT_IN_GATE')
        WHERE evt.APPLIED_TO_GKEY = u.GKEY
        AND evt.APPLIED_TO_CLASS = 'UNIT' AND ROWNUM = 1) as FechaIngreso
FROM            usrtosn4p.inv_unit                          U
INNER JOIN      usrtosn4p.inv_unit_fcy_visit                ufv         ON u.active_ufv = ufv.gkey
LEFT OUTER JOIN usrtosn4p.ORD_EQUIPMENT_ORDER_ITEMS         item        ON u.DEPART_ORDER_ITEM_GKEY = item.GKEY
LEFT JOIN       usrtosn4p.INV_EQ_BASE_ORDER_ITEM            ibOrdItm    ON ibOrdItm.GKEY = item.GKEY
LEFT JOIN       usrtosn4p.INV_EQ_BASE_ORDER                 ibOrd       ON ibOrd.GKEY = ibOrdItm.EQO_GKEY
LEFT JOIN       usrtosn4p.ARGO_CARRIER_VISIT                ibCv        ON ibcv.GKEY = ibOrd.VESSEL_VISIT_GKEY
                LEFT JOIN       usrtosn4p.ARGO_VISIT_DETAILS                vd          ON ibCv.CVCVD_GKEY = vd.GKEY
                LEFT JOIN       usrtosn4p.VSL_VESSEL_VISIT_DETAILS          vvd         ON vd.GKEY = vvd.VVD_GKEY
                LEFT JOIN       usrtosn4p.VSL_VESSELS                       vsl         ON vvd.VESSEL_GKEY = vsl.GKEY
WHERE u.visit_state = '1ACTIVE' 
and vsl.NAME is not null
and rownum <=100;

