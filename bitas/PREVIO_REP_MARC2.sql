--select id, category from USRTOSN4P.inv_unit;
--select id, count(id) zz from USRTOSN4P.inv_unit group by id;
--Select category from USRTOSN4P.inv_unit group by category;
--SELECT * FROM USRTOSN4P.VSL_VESSEL_VISIT_DETAILS;


Select 
'DPWCALLAO' as bu_name,
CASE WHEN U.category = 'EXPRT' THEN 'Export'
     WHEN U.category = 'IMPRT' THEN 'Import'
END     as impexp_typr,
U.ID    as container_num,
--RFS.ID  as shippingLineOperator,
RFS.name  as shipping_line_operator,
--VS.ID   as Vessel,                                              --Inbound_Vessel,
VS.name as Vessel,
--VVD.IN_CUSTOMS_VOY_NBR as voyage_num,                           --inbound_Voyage,
VVD.IB_VYG as voyage_num,
TO_CHAR(CV.ATA, 'YYYYMMDD') as arrival_date,
TO_CHAR(CV.ATD, 'YYYYMMDD') as departure_date,

RUC_ORI.PLACE_NAME ||' , '|| CNTRY_ORI.CNTRY_NAME AS Origin_Country,
RUC_BQO.PLACE_NAME ||' , '|| CNTRY_BQO.CNTRY_NAME AS port_of_landing,

RUC_DES.PLACE_NAME ||' , '|| CNTRY_DES.CNTRY_NAME AS destination_country,
RUC_BQD.PLACE_NAME ||' , '|| CNTRY_BQD.CNTRY_NAME AS port_of_unlading,
/*
CNTRY_BLO.CNTRY_NAME AS Origin_Country,
RUC_BLO.PLACE_NAME  as port_of_landing,
CNTRY_BQD.CNTRY_NAME AS DestinationCountry,
RUC_BQD.PLACE_NAME as port_of_landing,
*/
--RRP.UNLOC_GKEY AS UNLOCK1, RRP2.UNLOC_GKEY AS UNLOCK2,
--RUC2.PLACE_NAME ||' / '|| CNTRY2.CNTRY_NAME AS CountryDestino

--RET.NOMINAL_LENGTH as tamañoPrueba,
CASE RET.NOMINAL_LENGTH WHEN 'NOM40' THEN 2 ELSE 1 END  AS TEU,
'' as Goods_Value_USD,
'' as notifier_name,

RFS_CN.ID as Consignee_name,
RFS_SH.ID as shipper_name,
--RC.ID AS item_description,
'' AS item_description,
U.CUSTDFF_BL_MASTER as bl_no
--BL.NBR as bl_no
From USRTOSN4P.inv_unit U
    LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV           ON U.GKEY = UFV.UNIT_GKEY
    LEFT OUTER JOIN USRTOSN4P.argo_carrier_visit CV            ON (CV.GKEY = UFV.INTEND_OB_CV OR CV.GKEY = U.DECLRD_IB_CV)
    LEFT OUTER JOIN USRTOSN4P.vsl_vessel_visit_details VVD     ON CV.CVCVD_GKEY = VVD.VVD_GKEY
    LEFT OUTER JOIN USRTOSN4P.VSL_VESSELS VS                   ON VS.GKEY = VVD.VESSEL_GKEY
 --   LEFT OUTER JOIN USRTOSN4P.INV_GOODS GD                     ON U.GOODS = GD.GKEY

    LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS          ON RFS.GKEY = U.LINE_OP
    

    --Ref BLs
   -- LEFT OUTER JOIN USRTOSN4P.CRG_BL_GOODS CBD                 ON CBD.GDS_GKEY = GD.GKEY
 --   LEFT OUTER JOIN USRTOSN4P.CRG_BILLS_OF_LADING BL           ON BL.GKEY = CBD.BL_GKEY = 
     LEFT OUTER JOIN USRTOSN4P.CRG_BILLS_OF_LADING BL           ON BL.NBR = U.CUSTDFF_BL_MASTER AND BL.COMPLEX_GKEY = U.COMPLEX_GKEY
    
    LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_ORI ON   RRP_ORI.GKEY = U.OPL_GKEY 
   LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_ORI ON RUC_ORI.GKEY = RRP_ORI.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_ORI ON CNTRY_ORI.CNTRY_CODE = RUC_ORI.CNTRY_CODE 
   
   
   LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_DES ON   RRP_DES.GKEY = U.POD2_GKEY 
   LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_DES ON RUC_DES.GKEY = RRP_DES.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_DES ON CNTRY_DES.CNTRY_CODE = RUC_DES.CNTRY_CODE 
   
                
        --BOOKING origen
        LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_BQO ON   RRP_BQO.GKEY = U.POL_GKEY 
                LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_BQO ON RUC_BQO.GKEY = RRP_BQO.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_BQO ON CNTRY_BQO.CNTRY_CODE = RUC_BQO.CNTRY_CODE 


        --BOOKING Destino
        LEFT OUTER JOIN USRTOSN4P.REF_ROUTING_POINT RRP_BQD ON   RRP_BQD.GKEY = U.POD1_GKEY 
                LEFT OUTER JOIN USRTOSN4P.REF_UNLOC_CODE  RUC_BQD ON RUC_BQD.GKEY = RRP_BQD.UNLOC_GKEY
                LEFT OUTER JOIN USRTOSN4P.REF_COUNTRY CNTRY_BQD ON CNTRY_BQD.CNTRY_CODE = RUC_BQD.CNTRY_CODE
                
                
    
    --Ref Booking
    LEFT OUTER JOIN USRTOSN4P.INV_EQ_BASE_ORDER_ITEM EQBOI on U.DEPART_ORDER_ITEM_GKEY = EQBOI.GKEY
    LEFT OUTER JOIN USRTOSN4P.INV_EQ_BASE_ORDER EQBO on EQBO.GKEY = EQBOI.EQO_GKEY  
    
    
    
--LEFT JOIN USRTOSN4P.ORD_EQUIPMENT_ORDER_ITEMS OED ON (OED.GKEY = EQBOI.GKEY)
--LEFT JOIN USRTOSN4P.REF_COMMODITY RC ON OED.COMMODITY_GKEY = RC.GKEY
  
       


        LEFT OUTER JOIN USRTOSN4P.REF_EQUIPMENT RE ON U.ID = RE.ID_FULL
        LEFT OUTER JOIN USRTOSN4P.REF_EQUIP_TYPE RET  ON RET.GKEY =RE.EQTYP_GKEY



LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS_CN       ON RFS_CN.GKEY = BL.CONSIGNEE_GKEY
LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS_SH       ON RFS_SH.GKEY = BL.SHIPPER_GKEY






                
--LEFT OUTER JOIN USRTOSN4P.argo_carrier_visit CV ON CV.GKEY = U.GKEY;
WHERE U.category IN ('IMPRT')
--WHERE U.category IN ('EXPRT','IMPRT')
--AND EXTRACT(YEAR FROM CV.ATA) IN (2018,2019)
and CV.ATA between '01/01/2018' and '31/12/2019'
AND UFV.FCY_GKEY = 46182;
--AND U.ID = 'TEMU8724034';
--AND U.ID = 'HASU5046660';
--AND ROWNUM <= 1000;
--AND RUC.PLACE_NAME IS NOT NULL;

/*
UN LOCATION
COUNTRIES
COUNTRIE

SELECT * FROM USRTOSN4P.REF_ROUTING_POINT    (  CON UNLOC_GKEY)
POL_GKEY
POD1_GKEY

SELECT * FROM USRTOSN4P.REF_UNLOC_CODE
SELECT * FROM USRTOSN4P.REF_COUNTRY

SELECT * FROM USRTOSN4P.CRG_BILLS_OF_LADING  WHERE NOTIFY_PTY3_NAME IS NOT NULL




select * from USRTOSN4P.INV_UNIT
select * from USRTOSN4P.argo_carrier_visit;
select * from USRTOSN4P.vsl_vessel_visit_details;

select * from USRTOSN4P.vsl_vessels;
 
select * from USRTOSN4P.INV_UNIT_FCY_VISIT;
--VSL_VESSELS  ID


 select * from USRTOSN4P.INV_GOODS where ORIGIN IS NOT NULL
           
 select * from USRTOSN4P.CRG_BL_GOODS CBD      
 select * from USRTOSN4P.CRG_BILLS_OF_LADING BL
 
 select * from USRTOSN4P.INV_UNIT_FCY_VISIT
 
 
 -- OJO:
 -- nbr  = 19  (EL ULTIMO CAMPO.....)
 -- de la tabla USRTOSN4P.CRG_BILLS_OF_LADING
select * from USRTOSN4P.CRG_BILLS_OF_LADING;
select * from USRTOSN4P.REF_ROUTING_POINT;

*/

--select * from USRTOSN4P.INV_EQ_BASE_ORDER;

--select * from  USRTOSN4P.CRG_BILLS_OF_LADING;
--select ROLE from  USRTOSN4P.REF_BIZUNIT_SCOPED GROUP BY ROLE;
            /*
            CUSTOMS
            HAULIER
            AGENT
            LINEOP
            DEPOT
            SHIPPER
            */
            
select * from  USRTOSN4P.REF_BIZUNIT_SCOPED;   
select * from USRTOSN4P.REF_BIZUNIT_MASTER;

select * from USRTOSN4P.CRG_BL_ITEM;
select * from USRTOSN4P.CRG_BILLS_OF_LADING;

 -- OJO:
 -- nbr  = 19  (EL ULTIMO CAMPO.....)
 -- de la tabla USRTOSN4P.CRG_BILLS_OF_LADING
select * from USRTOSN4P.CRG_BILLS_OF_LADING;
select * from USRTOSN4P.vsl_vessel_visit_details;
