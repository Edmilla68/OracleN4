SELECT segment_name AS "TABLE_NAME",
SUM (BYTES) AS "[Bytes]",
SUM (BYTES) / 1024 AS "[Kb]",
SUM (BYTES) / (1024*1024) AS "[Mb]",
SUM (BYTES) / (1024*1024*1024) AS "[Gb]"
FROM dba_segments
WHERE owner = 'USRTOSN4P' and segment_type = 'TABLE'
GROUP BY segment_name order by "[Bytes]" desc;



SELECT segment_name AS "TABLE_NAME",
SUM (BYTES) AS "[Bytes]",
SUM (BYTES) / 1024 AS "[Kb]",
SUM (BYTES) / (1024*1024) AS "[Mb]",
SUM (BYTES) / (1024*1024*1024) AS "[Gb]"
FROM dba_segments
WHERE segment_name = 'INV_MOVE_EVENT' and segment_type = 'TABLE'
GROUP BY segment_name order by "[Bytes]";


select * from all_tables
where owner = 'USRTOSN4P'
and table_name like '%EVENT%';


SELECT owner, table_name, num_rows, sample_size, last_analyzed 
FROM all_tables
WHERE owner = 'USRTOSN4P' AND NUM_ROWS IS NOT NULL
ORDER BY sample_size DESC;
--259,577,874

SELECT * FROM USRTOSN4P.SRV_EVENT
WHERE ROWNUM < 10
and cast(PLACED_TIME as date) >=  TO_DATE('2020-03-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
;

SELECT * FROM  SYS.all_indexes
WHERE INCLUDE_COLUMN IS NOT NULL
ORDER BY INDEX_NAME;




Select table_name, index_name, column_name 
FROM sys.all_column 
WHERE --INCLUDE_COLUMN IS NOT NULL;
table_name like 'SRV_EVENT' 
Order by table_name, column_name;


select * from sys.all_tables
where owner = 'sys' AND table_name LIKE 'all%';



Select *
From v$object_usage
WHERE table_name = 'SRV_EVENT';


select * from ALL_TAB_COLUMNS
WHERE table_name = 'SRV_EVENT';

select * from DBA_TAB_COLUMNS
WHERE table_name = 'SRV_EVENT';

select * from USER_TAB_COLUMNS
WHERE table_name = 'SRV_EVENT';


select * from ALL_IND_COLUMNS
WHERE table_name = 'SRV_EVENT'
order by index_name;





/*
select
           u.name "owner",
           io.name "index_name",
           t.name "table_name",
           decode(bitand(i.flags, 65536), 0, 'no', 'yes') "monitoring",
           decode(bitand(nvl(ou.flags,0), 1), 0, 'no', 'yes') "used",
           ou.start_monitoring "start_monitoring",
           ou.end_monitoring "end_monitoring"
         from
           sys.obj$ io,
           sys.obj$ t,
           sys.ind$ i,
           sys.object_usage ou,
           sys.user$ u
        where
           t.obj# = i.bo#
           and
          io.owner# = u.user#
          and
          io.obj# = i.obj#
          and
          u.name in ('<OWNER>')
          and
          i.obj# = ou.obj#(+);
*/