-- oracle db 관리자에서 hr유저에게 권한을 부여하는 작업
select * from dba_users;

alter user hr identified by hr account unlock;
select * from dba_users;
