
select sql_id, ROUND(sum(t.elapsed_time_delta/1000000)/(case when sum(t.executions_delta) = 0 then 1 else sum(t.executions_delta) end),4) elapsed_time_sec
--sum(t.elapsed_time_delta/1000000)/sum(t.executions_delta)
from   dba_hist_sqlstat t, dba_hist_snapshot s
where  t.snap_id = s.snap_id
and    t.dbid = s.dbid
and    t.instance_number = s.instance_number
and    s.begin_interval_time between trunc(sysdate)-1 and trunc(sysdate) -- yesterday's stats
group  by sql_id
ORDER BY elapsed_time_sec DESC

/*
select * 
from   dba_hist_sqlstat t, dba_hist_snapshot s
where  t.snap_id = s.snap_id
and    t.dbid = s.dbid
and    t.instance_number = s.instance_number
and    s.begin_interval_time between trunc(sysdate)-1 and trunc(sysdate) -- yesterday's stats
*/

/*
select instance_number, sql_id, snap_id,ELAPSED_TIME_DELTA,elapsed_time_total,
       round((elapsed_time_total/1000000)/(case when elapsed_time_total = 0 then 1 else elapsed_time_total end),4) time_per_exec,
       round(elapsed_time_total/1000000, 4) elapsed_time_total_x
from dba_hist_sqlstat
*/