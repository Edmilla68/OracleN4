SELECT SID,           
       s.osuser,       
       s.username,     
       s.machine,      
       s.program,      
       to_char(logon_time,'DD/MM/YYYY HH24:MI:SS'),
       s.logon_time,   
       s.Lockwait,
       s.SQL_ID,
       z.elapsed_time_sec
  FROM v$session s, 
      (select sql_id, ROUND(sum(t.elapsed_time_delta/1000000)/(case when sum(t.executions_delta) = 0 then 1 else sum(t.executions_delta) end),4) elapsed_time_sec
        from   dba_hist_sqlstat t, dba_hist_snapshot s
        where  t.snap_id = s.snap_id
        and    t.dbid = s.dbid
        and    t.instance_number = s.instance_number
        and    s.begin_interval_time between trunc(sysdate)-1 and trunc(sysdate) -- yesterday's stats
        group  by sql_id) z
WHERE s.SQL_ID = z.SQL_ID
AND   s.type = 'USER'
AND   s.status = 'ACTIVE'
AND   s.SQL_ID IS NOT NULL;






