Shell Script Testing
-----------------------------------

###
    This is shell script 

###
    1.Intercept mysql sql 

    sach as
    script:
    select user_id, user_name, phone from user;
    sql job will send info to ./sql.dump

    now use sql script to create new sql 
    enter: inster into shop(user_id , user_name, user_phone) values

    then the script will create new sql to ./sql.script

###
    2.use intSql.sh
    ./intSql.sh root 123 127.0.0.1
    parm0: username
    parm1: passwd
    parm2: db ip

    show view to select
    =======================    Intercept sql     ======================
    = 1.Intercept mysql with sql statement                            =
    = 2.Intercept mysql with sql script file                          =
    ===================================================================

    please enter param: 1
    please enter sql script
    use 690db; select * from snz_address_factory;
    
    please enter sql script head:
    insert into user_address values