CREATE USER &1 IDENTIFIED BY &2;
grant connect,resource,unlimited tablespace,create any view to &1;
commit;
exit;