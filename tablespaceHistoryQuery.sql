select TABLESPACE_SIZE*8/1024/1024 ,TABLESPACE_MAXSIZE*8/1024/1024 ,TABLESPACE_USEDSIZE*8/1024/1024  ,RTIME  
from DBA_HIST_TBSPC_SPACE_USAGE
where TABLESPACE_ID=(
	select TS# 
	from v$tablespace 
	where NAME = 'tablespace_name')  
order by SNAP_ID;
