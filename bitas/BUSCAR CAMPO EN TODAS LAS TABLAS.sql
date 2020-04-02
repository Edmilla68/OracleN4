--select * from  USRTOSN4P.argo_carrier_visit CV      
--select * from  USRTOSN4P.vsl_vessel_visit_details VVD
--select * from  USRTOSN4P.VSL_VESSELS VS              
--select * from  USRTOSN4P.INV_GOODS GD                

--LEFT OUTER JOIN USRTOSN4P.REF_BIZUNIT_SCOPED RFS       ON RFS.GKEY = U.LINE_OP
SELECT * FROM USRTOSN4P.INV_UNIT; --unidades
SELECT * FROM USRTOSN4P.REF_BIZUNIT_SCOPED;  -- line operator o shiper en un mismo campo....

select * from all_tab_columns where owner = 'USRTOSN4P' AND column_name like '%CONSIGNEE%' ORDER BY COLUMN_NAME;

SELECT * FROM USRTOSN4P.crg_bills_of_lading where shipper_gkey is not null;

SELECT * FROM USRTOSN4P.INV_WQ  --COLA DE TRABAJO
    SELECT * FROM USRTOSN4P.REF_EQUIP_TYPE