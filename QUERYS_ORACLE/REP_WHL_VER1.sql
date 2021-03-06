Select 
U.ID    ,
ret.id AS "Type Arch ISO",
REG.ID AS Clase,
U.FLEX_STRING03 as "Costo / Fecha AProbacion",
U.CUSTDFF_FLEX_STRING14,

re.tare_kg,
ret.safe_weight_kg,
ret.tare_weight_kg,
re.build_date,
ufv.time_in,
REC.ID as Condition,
EQBO.NBR


--ufv.*
--ufv.create_time,
--eqbo.created

--inveqs.grade_gkey,  --GRADO



From USRTOSN4P.inv_unit U
    LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV           ON U.GKEY = UFV.UNIT_GKEY
    LEFT OUTER JOIN USRTOSN4P.argo_carrier_visit CV            ON (CV.GKEY = UFV.ACTUAL_OB_CV) --OR CV.GKEY = U.DECLRD_IB_CV)
    LEFT OUTER JOIN USRTOSN4P.vsl_vessel_visit_details VVD     ON CV.CVCVD_GKEY = VVD.VVD_GKEY
    LEFT OUTER JOIN USRTOSN4P.VSL_VESSELS VS                   ON VS.GKEY = VVD.VESSEL_GKEY
    LEFT OUTER JOIN USRTOSN4P.INV_GOODS GD                     ON U.GOODS = GD.GKEY
    LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS          ON RFS.GKEY = U.LINE_OP
    LEFT OUTER JOIN USRTOSN4P.INV_EQ_BASE_ORDER_ITEM EQBOI on U.DEPART_ORDER_ITEM_GKEY = EQBOI.GKEY
    LEFT OUTER JOIN USRTOSN4P.INV_EQ_BASE_ORDER EQBO on EQBO.GKEY = EQBOI.EQO_GKEY  
    LEFT JOIN USRTOSN4P.ORD_EQUIPMENT_ORDER_ITEMS OED ON (OED.GKEY = EQBOI.GKEY)
    LEFT JOIN USRTOSN4P.REF_COMMODITY RC ON OED.COMMODITY_GKEY = RC.GKEY
    LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_ORI ON   RRP_ORI.GKEY = U.OPL_GKEY 
    LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_ORI ON RUC_ORI.GKEY = RRP_ORI.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_ORI ON CNTRY_ORI.CNTRY_CODE = RUC_ORI.CNTRY_CODE 
    LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_DES ON   RRP_DES.GKEY = U.POD2_GKEY 
    LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_DES ON RUC_DES.GKEY = RRP_DES.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_DES ON CNTRY_DES.CNTRY_CODE = RUC_DES.CNTRY_CODE 
    LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_BQO ON   RRP_BQO.GKEY = U.POL_GKEY 
                LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_BQO ON RUC_BQO.GKEY = RRP_BQO.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_BQO ON CNTRY_BQO.CNTRY_CODE = RUC_BQO.CNTRY_CODE 
    LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_BQD ON   RRP_BQD.GKEY = U.POD1_GKEY 
                LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_BQD ON RUC_BQD.GKEY = RRP_BQD.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_BQD ON CNTRY_BQD.CNTRY_CODE = RUC_BQD.CNTRY_CODE 
    
    LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE ON U.ID = RE.ID_FULL
    LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET  ON RET.GKEY =RE.EQTYP_GKEY
    
    LEFT OUTER JOIN USRTOSN4P.INV_EQ_STATE INVEQS ON inveqs.gkey = U.EQS_GKEY
                left OUTER join USRTOSN4P.REF_EQUIP_GRADES REG ON REG.GKEY = inveqs.grade_gkey
                
    LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_CONDITIONS REC ON REC.GKEY = U.CONDITION_GKEY
                
    
WHERE ufv.time_in >= TO_DATE('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
AND U.CUSTDFF_FLEX_STRING14 IS NOT NULL
;

--U.ID  = 'WHLU7750097';
--'WHSU2001954';
--'WHLU5520500';
--U.category IN ('EXPRT')
--and CV.ATA between '01/01/2018' and '31/12/2019'
--AND UFV.FCY_GKEY = 46182
--AND rownum <= 100;




/*

CASE WHEN U.category = 'EXPRT' THEN 'Export'
     WHEN U.category = 'IMPRT' THEN 'Import'
END     as impexp_typr,


*/


/*

RFS.name  as shipping_line_operator,
VS.name as Vessel,
VVD.OB_VYG as voyage_num,
TO_CHAR(CV.ATA, 'YYYYMMDD') as arrival_date,
TO_CHAR(CV.ATD, 'YYYYMMDD') as departure_date,
RUC_ORI.PLACE_NAME ||' , '|| CNTRY_ORI.CNTRY_NAME AS Origin_Country,
RUC_BQO.PLACE_NAME ||' , '|| CNTRY_BQO.CNTRY_NAME AS port_of_landing,
RUC_DES.PLACE_NAME ||' , '|| CNTRY_DES.CNTRY_NAME AS destination_country,
RUC_BQD.PLACE_NAME ||' , '|| CNTRY_BQD.CNTRY_NAME AS port_of_unlading,
CASE RET.NOMINAL_LENGTH WHEN 'NOM40' THEN 2 ELSE 1 END  AS TEU,
'' as Goods_Value_USD,
'' as notifier_name,
'' as Consignee_name,
'' as shipper_name,
RC.ID AS item_description,
'' as bl_no

*/