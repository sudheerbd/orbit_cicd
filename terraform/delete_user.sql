select 'alter system kill session ''' || sid || ',' || serial# || ''';' from v$session where username = &1

DROP USER &1 CASCADE;
quit;