select * from USRTOSN4P.ref_equip_type
where iso_group = 'RT';


select * from USRTOSN4P.ref_equipment
where id = 'BMOU9642852';

select * from USRTOSN4P.ref_line_operator
where lineop_id = 18410418;

select * from USRTOSN4P.inv_unit
WHERE id = 'TCNU3459540';

select * from USRTOSN4P.INV_UNIT_FCY_VISIT
WHERE UNIT_GKEY = '3863078788';
LastKnownPosition
Last_Pos_Name

select * from USRTOSN4P.argo_carrier_visit
WHERE ID = 'CCAL0JX3GW';


select * from USRTOSN4P.REF_BIZUNIT_SCOPED;
where gkey = 18410418;

select nominal_length from USRTOSN4P.REF_EQUIP_TYPE
group by nominal_length;


 SELECT 'CAMPO = '||CHR(39)||'%'||1103537||'%'||CHR(39) as "cc" FROM DUAL;



select initcap(trim(SUBSTR(transit_state ,5,length(transit_state)))), transit_state  from USRTOSN4P.INV_UNIT_FCY_VISIT
group by transit_state;

select initcap(trim(SUBSTR(visit_state ,2,length(visit_state)))), visit_state  from USRTOSN4P.INV_UNIT_FCY_VISIT
group by visit_state;



select * from USRTOSN4P.INV_UNIT_FCY_VISIT;


select initcap('pepito perez') from dual;


select TRUNC(CURRENT_DATE) - TO_DATE('05/09/2019') AS DIAS from dual;


select * from USRTOSN4P.REF_EQUIPMENT
WHERE id = 'CMAU4135668'; 
select * from USRTOSN4P.REF_EQUIP_TYPE
where GKEY = 1766;


select * from USRTOSN4P.srv_event;
select * from USRTOSN4P.srv_event_types;
select * from USRTOSN4P.inv_move_event;
 
  --mveCheFetchLoginName

select CATEGORY from USRTOSN4P.inv_unit
GROUP BY CATEGORY;


select * from USRTOSN4P.XPS_CHE;


SELECT  U.REQUIRES_POWER, GD.HAZARDOUS, U.IS_OOG 
FROM USRTOSN4P.INV_UNIT U
LEFT OUTER JOIN USRTOSN4P.INV_GOODS GD                 ON U.GOODS = GD.GKEY;

 

