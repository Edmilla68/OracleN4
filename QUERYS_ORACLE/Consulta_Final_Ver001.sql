Select SRVE.applied_to_natural_key,
SRVTIP.ID,
srve.placed_time,
srve.placed_by,
SRVE.GKEY, 
    (SELECT LISTAGG(NVL(prior_value,'(null)') ||' -> ' ||new_value, ', ') WITHIN GROUP (ORDER BY event_gkey)  "Changes"
    FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES WHERE event_gkey = SRVE.GKEY) AS "CHANGES"
FROM USRTOSN4P.srv_event SRVE
INNER JOIN USRTOSN4P.SRV_EVENT_TYPES SRVTIP ON SRVTIP.GKEY = srve.event_type_gkey
--WHERE SRVE.applied_to_natural_key = 'TLLU5016433'
WHERE srve.placed_time >= TRUNC(SYSDATE)-111
order by SRVE.placed_time desc;






/*
SELECT LISTAGG(NVL(prior_value,'(null)') ||' -> ' ||new_value, ', ') WITHIN GROUP (ORDER BY event_gkey)  "Changes"
FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES WHERE event_gkey = '4054745268';
*/



/*

*/



/*

Select event_gkey, NVL(prior_value,'(null)') ||' -> ' ||new_value AS CHANGED
FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES
WHERE event_gkey ='4054745268';



Select event_gkey, NVL(prior_value,'(null)') ||' -> ' ||new_value AS CHANGED
FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES
WHERE event_gkey ='4054745268';





--ISNULL(prior_value,'NULO') +
SELECT 
LISTAGG(NEW_VALUE, ', ') WITHIN GROUP (ORDER BY event_gkey)  "Changes",
MAX(event_gkey)
FROM USRTOSN4P.SRV_EVENT_FIELD_CHANGES
WHERE event_gkey = '4054745268';


*/