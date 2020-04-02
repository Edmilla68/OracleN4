prompt Hola1
set linesize 200 trimspool on pagesize 60 verify off
column begin_interval_time format a35
column end_interval_time format a35
prompt Hola2
break on sql_id skip 1 on instance_number column sdate new_value sdt noprint

prompt Hola4
select to_char(sysdate, 'YYYYMMDDHHMI') sdate from dual;

prompt Hola

spool &sdt._elapsed_time_report.log

prompt 
prompt  Historic
prompt 
prompt  Elapsed by exec
prompt 

select distinct x.instance_number, x.sql_id, x.time_per_exec, x.elapsed_time_total, s.begin_interval_time, s.end_interval_time
from
(select instance_number, sql_id, snap_id,
       round((elapsed_time_total/1000000)/(case when elapsed_time_total = 0 then 1 else elapsed_time_total end),4) time_per_exec,
       round(elapsed_time_total/1000000, 4) elapsed_time_total
from dba_hist_sqlstat) x, (select snap_id, 
                                  max(begin_interval_time) begin_interval_time, 
                                  max(end_interval_time) end_interval_time
                           from dba_hist_snapshot 
                           group by snap_id) s
where s.snap_id = x.snap_id 
and x.time_per_exec > &&1
and x.time_per_exec <> x.elapsed_time_total
order by 2 asc, 3 desc, 6 desc
/

clear breaks

prompt 
prompt  Elapsed time total, current statements
prompt 

select inst_id,
       sql_id,
       elapseds,
       round(elapsed_time/1000000, 6) elapsed_sec,
       round((elapsed_time/1000000)/(case when elapseds = 0 then 1 else elapseds end), 6) elapsed_per_exec,
       last_active_time
from gv$sqlstats
where elapsed_time/1000000 > &&1
order by 4 desc
/

prompt 
prompt  Elapsed per exec, current statements
prompt 

select inst_id,
       sql_id,
       elapseds,
       round(elapsed_time/1000000, 6) elapsed_sec,
       round((elapsed_time/1000000)/(case when elapseds = 0 then 1 else elapseds end), 6) elapsed_per_exec,
       last_active_time
from gv$sqlstats
where elapsed_time/1000000 > &&1
order by 5 desc
/

set linesize 80 trimspool off

spool off