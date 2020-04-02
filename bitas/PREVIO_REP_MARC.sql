--select id, category from USRTOSN4P.inv_unit;
--select id, count(id) zz from USRTOSN4P.inv_unit group by id;
--Select category from USRTOSN4P.inv_unit group by category;
--SELECT * FROM USRTOSN4P.VSL_VESSEL_VISIT_DETAILS;


Select 

CASE WHEN U.category = 'EXPRT' THEN 'Export'
     WHEN U.category = 'IMPRT' THEN 'Import'
END     as impexp_typr,
U.ID    as container_num, 
TO_CHAR(CV.ATA, 'YYYYMMDD') as arrival_date,
TO_CHAR(CV.ATD, 'YYYYMMDD') as departure_date,
VS.ID   as Inbound_Vessel,
VVD.IN_CUSTOMS_VOY_NBR AS inbound_Voyage

--EXTRACT(YEAR FROM CV.ATA)
From USRTOSN4P.inv_unit U
    LEFT OUTER JOIN USRTOSN4P.INV_UNIT_FCY_VISIT UFV           ON U.GKEY = UFV.UNIT_GKEY
    LEFT OUTER JOIN USRTOSN4P.argo_carrier_visit CV            ON CV.GKEY = UFV.INTEND_OB_CV
    LEFT OUTER JOIN USRTOSN4P.vsl_vessel_visit_details VVD    ON CV.CVCVD_GKEY = VVD.VVD_GKEY
    LEFT OUTER JOIN USRTOSN4P.VSL_VESSELS VS                   ON VS.GKEY = VVD.VESSEL_GKEY
    
    LEFT OUTER JOIN USRTOSN4P.INV_GOODS GD                 ON U.GOODS = GD.GKEY
    LEFT OUTER JOIN USRTOSN4P.CRG_BL_GOODS CBD             ON CBD.GDS_GKEY = GD.GKEY
    LEFT OUTER JOIN USRTOSN4P.CRG_BILLS_OF_LADING BL       ON CBD.BL_GKEY = BL.GKEY
    
    --LEFT OUTER JOIN USRTOSN4P.argo_carrier_visit CV ON CV.GKEY = U.GKEY;
WHERE U.category IN ('EXPRT')
--WHERE U.category IN ('EXPRT','IMPRT');
AND EXTRACT(YEAR FROM CV.ATA) IN (2018,2019);

/*
UN LOCATION
COUNTRIES
COUNTRIE

SELECT * FROM USRTOSN4P.REF_ROUTING_POINT    (  CON UNLOC_GKEY)
POL_GKEY
POD1_GKEY

SELECT * FROM USRTOSN4P.REF_UNLOC_CODE
SELECT * FROM USRTOSN4P.REF_COUNTRY




select * from USRTOSN4P.argo_carrier_visit;
select * from USRTOSN4P.vsl_vessel_visit_details;

select * from USRTOSN4P.vsl_vessels;
 
select * from USRTOSN4P.INV_UNIT_FCY_VISIT;
--VSL_VESSELS  ID


 select * from USRTOSN4P.INV_GOODS where ORIGIN IS NOT NULL
           
 select * from USRTOSN4P.CRG_BL_GOODS CBD      
 select * from USRTOSN4P.CRG_BILLS_OF_LADING BL
 
 
 -- OJO:
 -- nbr  = 19  (EL ULTIMO CAMPO.....)
 -- de la tabla USRTOSN4P.CRG_BILLS_OF_LADING



*/