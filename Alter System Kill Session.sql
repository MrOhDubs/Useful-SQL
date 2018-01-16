
/*=============================
Alter system kill session
==============================*/

select  s.sid,
	s.serial#,
	s.username,
	s.program
from v$session s 
where s.username='&user';

alter system kill session '&SID, &serial';
