set heading off
set feed off
set ver off
spool killsession.sql
select 'alter system kill session ''' || sid || ',' || serial# || ''';' from v$session where username='&1';
spool off
@killsession.sql
DROP USER &1 CASCADE;
exit;