SELECT SID,           
       s.osuser,       
       s.username,     
       s.machine,      
       s.program,      
       to_char(logon_time,'DD/MM/YYYY HH24:MI:SS'),
       s.logon_time,   
       s.Lockwait,
       s.SQL_ID
FROM v$session s 
WHERE s.type = 'USER'
    AND   s.status = 'ACTIVE'
    AND   s.SQL_ID IS NOT NULL;