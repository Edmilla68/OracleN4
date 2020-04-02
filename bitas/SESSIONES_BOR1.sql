SELECT SID,            -- Identificador de sesión
       osuser,         -- Usuario de sistema operativo
       username,       -- Usuario de base de datos
       machine,        -- Máquina desde la que se realiza la conexión
       program,        -- Programa, que realiza la conexión
       to_char(logon_time,'DD/MM/YYYY HH24:MI:SS'),
       logon_time,     -- Hora de conexión
       Lockwait        -- Identifica si hay bloqueo
  FROM v$session 
  where type = 'USER'
AND status = 'ACTIVE'
ORDER BY osuser;

 --select * from v$sql;


--select  CURRENT_TIMESTAMP from dual;
/*
SELECT sid, status, Username, terminal, blocking_session_status, schemaname, a.name Command_Action, logon_time, program, SECONDS_IN_WAIT
FROM SYS.V_$SESSION s
INNER JOIN AUDIT_ACTIONS a ON s.command=a.action
WHERE status = 'ACTIVE'
order by SECONDS_IN_WAIT DESC;

--USERNAME = 'EMILLA';

SELECT sess.process,SECONDS_IN_WAIT, sess.status, sess.username, sess.schemaname, sql.sql_text
FROM v$session sess, v$sql sql
WHERE sql.sql_id(+) = sess.sql_id
AND sess.type = 'USER'
AND sess.status = 'ACTIVE';

*/