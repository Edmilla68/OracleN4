select sql_id, t.elapsed_time_delta/1000000, t.executions_delta, s.begin_interval_time, s.End_interval_time
        from   dba_hist_sqlstat t, dba_hist_snapshot s
        where  t.snap_id = s.snap_id
        and    t.dbid = s.dbid
        and    t.instance_number = s.instance_number
        and    s.begin_interval_time between trunc(sysdate)-1 and trunc(sysdate)
        and  sql_id = '8fpn652mduh4h';
        
        
        
        
        -- yesterday's stats
        
        
        --group  by sql_id
        
        --select * from dba_hist_sqlstat
        --select * from dba_hist_snapshot