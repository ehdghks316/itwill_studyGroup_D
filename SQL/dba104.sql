show user
select * from dba_users;

create user ora
identified by ora
default tablespace users
temporary tablespace temp
quota 10m on users;

grant create session to ora;
