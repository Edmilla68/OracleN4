SELECT
    case nvl(ar.rfr_type,'NON_RFR') when 'NON_RFR' then 'DRY' else 'REEFER' end as TipoReefer,
    cast(u.gkey as varchar2(30))    as IdContenedor,
    u.id                            as NumeroContenedor,
    arch.id                         as Arquetipo,
    ret.id                          as Iso,
    ret.nominal_length              as LongitudNominal,
    line.id                         as CodigoLinea,
    line.name                       as NombreLinea,
    line.id                         as Linea,
    bkg.NBR                        as NumeroBooking,
    bkg.CUSTDFF_EDO_FLEX_STRING15 as Producto,
    bkg.CUSTDFF_EQBO_FLEX_STRING20 as ServicioIntegral,
    agent.ID   as AgentDocument,
    shipper.ID   as ShipperDocument,
    truck.ID   as TruckDocument,
    bkg.CUSTDFF_EDO_FLEX_STRING05 as Cliente,
    vsl.NAME                        AS Nave,
    vvd.OB_VYG                      AS Viaje,
    ttran.CREATED            FechaIngresoCamion

FROM  usrtosn4p.inv_unit u 


    inner join              usrtosn4p.inv_unit_fcy_visit            ufv         on u.active_ufv = ufv.gkey
    left join               usrtosn4p.ref_bizunit_scoped            line        on line.gkey = u.line_op
    left outer join         usrtosn4p.ref_equip_conditions          rec         on rec.gkey = u.condition_gkey
    left outer join         usrtosn4p.ref_equip_grades              reg         on reg.gkey = u.grade_gkey
    inner join              usrtosn4p.ref_equipment                 re          on u.eq_gkey = re.gkey
    inner join              usrtosn4p.ref_equip_type                ret         on re.eqtyp_gkey = ret.gkey
    left join               usrtosn4p.ref_equip_type                ar          on ar.gkey = ret.archetype and ar.is_archetype = 1
    left join               usrtosn4p.ref_equip_type                arch        on arch.gkey = ret.archetype



      
    
    left outer join         usrtosn4p.road_truck_transactions       ttran       on (ttran.unit_gkey = u.gkey)                        --AND tvd.tvdtls_gkey = ttran.truck_visit_gkey 
    left outer join         usrtosn4p.road_truck_visit_details      tvd         on tvd.tvdtls_gkey = ttran.truck_visit_gkey          AND tvd.tvdtls_gkey = ttran.truck_visit_gkey  AND 
    
    
    
    
    left  outer join        usrtosn4p.ORD_EQUIPMENT_ORDER_ITEMS     item        on u.DEPART_ORDER_ITEM_GKEY = item.GKEY
    left  outer join        usrtosn4p.INV_EQ_BASE_ORDER_ITEM        baseItem    on baseItem.GKEY = item.GKEY
    left  outer join        usrtosn4p.inv_eq_base_order             bkg         on baseItem.eqo_gkey = bkg.gkey
    
    
    inner join              usrtosn4p.argo_carrier_visit            oacv        on oacv.gkey = bkg.VESSEL_VISIT_GKEY
    left  outer join        usrtosn4p.argo_visit_details            obvd        on obvd.gkey = oacv.cvcvd_gkey
    
    left outer join         usrtosn4p.VSL_VESSEL_VISIT_DETAILS      vvd         ON obvd.GKEY = vvd.VVD_GKEY                         and (obvd.gkey = tvd.tvdtls_gkey) -- and (obcv.carrier_mode = 'TRUCK')
    left outer join         usrtosn4p.VSL_VESSELS                   vsl         ON vvd.VESSEL_GKEY = vsl.GKEY
    
    /*
    inner join              usrtosn4p.inv_unit_fcy_visit            ufv         on u.active_ufv = ufv.gkey
    inner join              usrtosn4p.argo_carrier_visit            obcv        on obcv.gkey = ufv.ACTUAL_OB_CV
    left  outer join        usrtosn4p.ORD_EQUIPMENT_ORDER_ITEMS     item        on u.DEPART_ORDER_ITEM_GKEY = item.GKEY
    left  outer join        usrtosn4p.INV_EQ_BASE_ORDER_ITEM        baseItem    on baseItem.GKEY = item.GKEY
    left  outer join        usrtosn4p.inv_eq_base_order             bkg         on baseItem.eqo_gkey = bkg.gkey
    inner join              usrtosn4p.argo_carrier_visit            oacv        on oacv.gkey = bkg.VESSEL_VISIT_GKEY
    left  outer join        usrtosn4p.argo_visit_details            obvd        on obvd.gkey = oacv.cvcvd_gkey
    left outer join         usrtosn4p.road_truck_visit_details      tvd         on (obvd.gkey = tvd.tvdtls_gkey and obcv.carrier_mode = 'TRUCK')
      */
      
    
    left outer join         usrtosn4p.REF_BIZUNIT_SCOPED agent on bkg.AGENT_GKEY = agent.GKEY
    left outer join         usrtosn4p.REF_BIZUNIT_SCOPED shipper on bkg.SHIPPER_GKEY = shipper.GKEY
    left outer join         usrtosn4p.REF_BIZUNIT_SCOPED truck on bkg.TRUCK_CO_GKEY = truck.GKEY
    left outer join         usrtosn4p.REF_BIZUNIT_SCOPED operador on (bkg.CUSTDFF_EDO_FLEX_STRING13 = operador.GKEY) --operador
      

WHERE 
u.visit_state = '1ACTIVE' AND 
u.ID = 'CAIU7080890'

/*AND ufv.FCY_GKEY = 3575349521 AND u.Complex_GKEY = '3575349411'*/;