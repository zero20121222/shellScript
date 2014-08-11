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
