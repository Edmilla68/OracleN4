select column_name, data_length, data_type from all_tab_columns where table_name = 'INV_EQ_BASE_ORDER'
AND DATA_TYPE LIKE 'VARCHA%';


select concat('a','-','b') from dual;
select 'a'||','||'b' from dual;


select  * from USRTOSN4P.REF_BIZUNIT_SCOPED
--inv_unit u
--INV_EQ_BASE_ORDER
--INV_EQ_BASE_ORDER_ITEM
--
--inv_unit
WHERE rownum <= 100
--id = 'WHSU2001954'
;

--CUSTDFF_FLEX_STRING14

select *
from USRTOSN4P.INV_EQ_BASE_ORDER
--INV_UNIT_FCY_VISIT
--VSL_VESSEL_VISIT_DETAILS
WHERE ROWNUM <= 100
;






select ID, VISIT_STATE, FREIGHT_KIND, CREATE_TIME,LINE_OP
from USRTOSN4P.inv_unit
WHERE id = 'WHSU2001954';

select column_name, data_type, data_length
from all_tab_columns
where table_name = 'INV_UNIT' AND OWNER = 'USRTOSN4P'
AND COLUMN_NAME IN 
(
UPPER('ID'), 
UPPER('visit_state'), 
UPPER('freight_kind'), 
UPPER('create_time'), 
UPPER('line_op'))
;


select * from USRTOSN4P.inv_unit
WHERE rownum <= 100;
--id = 'WHSU2001954';
--169AA00249
--WHERE id = 'TCNU3459540';




select * from USRTOSN4P.ROAD_TRUCK_TRANSACTIONS --(SUB_TYPE)
--REF_EQUIP_CONDITIONS
WHERE rownum <= 100;


select * from USRTOSN4P.INV_UNIT_FCY_VISIT
WHERE rownum <= 100;

select * from USRTOSN4P.INV_EQ_BASE_ORDER
WHERE rownum <= 100;

--CODIGO INTEGRAL = CUSTDFF_EQBO_FLEX_STRING11

select * from USRTOSN4P.INV_UNIT_FCY_VISIT UFV
LEFT OUTER JOIN USRTOSN4P.INV_UNIT U ON U.GKEY = UFV.UNIT_GKEY
WHERE --time_move between '06/03/2020' and '07/03/2020';
U.ID = 'UACU3771626';
AND 
time_move  >=  TO_DATE('2020-03-06 15:30:00', 'YYYY-MM-DD HH24:MI:SS')
    AND time_move  <=  TO_DATE('2020-03-06 15:36:00', 'YYYY-MM-DD HH24:MI:SS');


select * from USRTOSN4P.argo_carrier_visit
WHERE --ATA between '06/03/2020 15:30' and '06/03/2020 15:35';
ATA >=  TO_DATE('2020-03-06 15:30:00', 'YYYY-MM-DD HH24:MI:SS')
    AND ATA <=  TO_DATE('2020-03-06 15:35:00', 'YYYY-MM-DD HH24:MI:SS');


--rownum <= 100;

select SUB_TYPE from USRTOSN4P.INV_EQ_BASE_ORDER
GROUP BY SUB_TYPE;
WHERE rownum <= 100;


select * from USRTOSN4P.REF_EQUIPMENT
where rownum <= 100;

select * from USRTOSN4P.REF_EQUIPMENT
WHERE rfr_type = 'PORTHOLE' and
rownum <= 100;






select * from USRTOSN4P.REF_EQUIP_TYPE
WHERE rownum <= 100;

select rfr_type from USRTOSN4P.REF_EQUIP_TYPE
group  by rfr_type;



gkey = 240;



SELECT * FROM USRTOSN4P.CUSTOM_TRUCK_COMPANY_CHASSIS;
SELECT * FROM USRTOSN4P.ARGO_FACILITY;


select * from all_tables
where owner = 'USRTOSN4P'
and table_name like '%EVENT%';


select * from USRTOSN4P.INV_EQ_STATE
WHERE rownum <= 100;

select * from USRTOSN4P.REF_EQUIP_GRADES;


select * from USRTOSN4P.REF_EQUIPMENT
WHERE rownum <= 100;

select * from USRTOSN4P.inv_eq_base_order
WHERE NBR = '169AA00249';

CUSTDFF_EQBO_FLEX_STRING05


select * from USRTOSN4P.inv_ar_eq_base_order
WHERE rownum <= 100;
WHERE NBR = '169AA00249';

SELECT FREIGHT_KIND FROM USRTOSN4P.INV_UNIT
GROUP BY FREIGHT_KIND;


select * from USRTOSN4P.INV_UNIT_FCY_VISIT
--UnitFacilityVisit
WHERE rownum <= 100;

select * from USRTOSN4P.INV_CUSTOM_ASSIGN_BOOKING_NEP 
WHERE rownum <= 100;

select EQ_STATUS from USRTOSN4P.inv_eq_base_order
GROUP BY EQ_STATUS;
WHERE NBR = '169AA00249';


SELECT * FROM USRTOSN4P.argo_carrier_visit
WHERE rownum <= 100;
