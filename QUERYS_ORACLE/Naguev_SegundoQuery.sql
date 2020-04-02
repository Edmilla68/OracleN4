SELECT
ufv.TRANSIT_STATE               AS EstadoTransito,
CASE NVL(ar.RFR_TYPE,'NON_RFR') WHEN 'NON_RFR' THEN 'DRY' ELSE 'REEFER' END AS TipoReefer,
CAST(u.gkey as varchar2(30))    AS IdContenedor,
u.Id                            AS NumeroContenedor,
arch.ID                         AS Arquetipo,
ret.id                          AS Iso,
ret.nominal_length              AS LongitudNominal,
u.Category                      AS Categoria,
NVL(re.TARE_KG,0)               AS Tara,
NVL(re.SAFE_KG,0)               AS SafeWeight,
NVL(re.SAFE_KG,0) - NVL(re.TARE_KG,0) AS Payload,
substr(ar.id, 1, 2)             AS TamanyoContenedor,
substr(ar.id, 3, 2)             AS TipoContenedor,
u.FLEX_STRING08                 AS TipoEntrada,
re.BUILD_DATE                   AS FechaFabricacion,
TO_CHAR(SYSDATE, 'DD-MM-YYYY')  AS FechaFabricacionStr,
agent.name                      AS AgenteCarga,
(SELECT evt.PLACED_TIME
                            FROM usrtosn4p.SRV_EVENT evt
                                  INNER JOIN usrtosn4p.SRV_EVENT_TYPES et
                                    ON evt.EVENT_TYPE_GKEY = et.GKEY  AND upper(et.id) IN ('INGATE','UNIT_IN_GATE')
                            WHERE evt.APPLIED_TO_GKEY = u.GKEY
                             AND evt.APPLIED_TO_CLASS = 'UNIT' AND ROWNUM = 1) as FechaIngreso,
                case when b.GKEY is null then vsl.NAME else vsl2.NAME end as Nave,
                case when b.GKEY is null then vvd.IB_VYG else vvd2.IB_VYG end as Viaje,
                eqc.ID                          AS EstadoCaja,
                agent.ID   as AgentDocument,
                shipper.ID   as ShipperDocument,
                truck.ID   as TruckDocument,
                operador.ID   as OperadorDocument,
                shipper.NAME as Cliente
                
                
FROM usrtosn4p.inv_unit u
                inner JOIN usrtosn4p.inv_unit_fcy_visit             ufv ON u.active_ufv = ufv.gkey
                INNER JOIN usrtosn4p.ref_equipment                  re ON u.eq_gkey = re.gkey
                INNER JOIN usrtosn4p.ref_equip_type                 ret ON re.eqtyp_gkey = ret.gkey
                LEFT JOIN usrtosn4p.ref_equip_conditions            eqc ON u.CONDITION_GKEY = eqc.GKEY
                LEFT JOIN usrtosn4p.ref_equip_type                  ar ON ar.gkey = ret.archetype AND ar.is_archetype = 1
                LEFT JOIN usrtosn4p.REF_EQUIP_TYPE                  arch ON arch.gkey = ret.archetype
        left outer join usrtosn4p.ORD_EQUIPMENT_ORDER_ITEMS         item on u.DEPART_ORDER_ITEM_GKEY = item.GKEY
                LEFT JOIN usrtosn4p.INV_EQ_BASE_ORDER_ITEM          ibOrdItm ON ibOrdItm.GKEY = item.GKEY
                LEFT JOIN usrtosn4p.INV_EQ_BASE_ORDER               ibOrd ON ibOrd.GKEY = ibOrdItm.EQO_GKEY
                LEFT JOIN usrtosn4p.ARGO_CARRIER_VISIT              ibCv ON ibcv.GKEY = ibOrd.VESSEL_VISIT_GKEY
                LEFT JOIN usrtosn4p.ARGO_VISIT_DETAILS              vd ON ibCv.CVCVD_GKEY = vd.GKEY
            LEFT JOIN usrtosn4p.VSL_VESSEL_VISIT_DETAILS            vvd ON vd.GKEY = vvd.VVD_GKEY
                LEFT JOIN usrtosn4p.VSL_VESSELS                     vsl ON vvd.VESSEL_GKEY = vsl.GKEY
                left outer join usrtosn4p.REF_BIZUNIT_SCOPED        agent on ibOrd.AGENT_GKEY = agent.GKEY
                left outer join usrtosn4p.REF_BIZUNIT_SCOPED        shipper on ibOrd.SHIPPER_GKEY = shipper.GKEY
                left outer join usrtosn4p.REF_BIZUNIT_SCOPED        truck on ibOrd.TRUCK_CO_GKEY = truck.GKEY
                left outer join usrtosn4p.REF_BIZUNIT_SCOPED        operador on ibOrd.CUSTDFF_EDO_FLEX_STRING13 = operador.GKEY
                LEFT JOIN usrtosn4p.inv_goods                       t   ON  t.gkey  = u.goods
                LEFT JOIN usrtosn4p.crg_bl_goods                    bg  ON  t.gkey  = bg.gds_gkey
                LEFT JOIN usrtosn4p.crg_bills_of_lading             b   ON  bg.bl_gkey = b.gkey
                LEFT JOIN usrtosn4p.ARGO_CARRIER_VISIT              acv ON acv.GKEY = b.CV_GKEY
                LEFT JOIN usrtosn4p.ARGO_VISIT_DETAILS              acvd ON acv.CVCVD_GKEY = acvd.GKEY
                LEFT JOIN usrtosn4p.VSL_VESSEL_VISIT_DETAILS        vvd2 ON acvd.GKEY = vvd2.VVD_GKEY
                LEFT JOIN usrtosn4p.VSL_VESSELS                     vsl2 ON vvd2.VESSEL_GKEY = vsl2.GKEY
WHERE u.visit_state = '1ACTIVE' 
and rownum <=100;

AND ufv.FCY_GKEY = :fcyParam 
AND ibOrd.nbr = 'EDOHLC003'  
AND u.Complex_GKEY = :cpxParam 
AND (  agent.ID = :rucAgente );

 
