SELECT sid, status, state, (WAIT_TIME_MICRO / 1000000) / 60, Username, terminal, blocking_session_status, schemaname, a.name Command_Action, logon_time, program
--sid, status, Username, terminal, blocking_session_status, schemaname, a.name Command_Action, logon_time, program
FROM SYS.V_$SESSION s
INNER JOIN AUDIT_ACTIONS a ON s.command=a.action
WHERE status = 'ACTIVE'
ORDER BY WAIT_TIME_MICRO DESC;


