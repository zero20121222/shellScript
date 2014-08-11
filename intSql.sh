#!/bin/sh
#Intercept mysql value to new sql script.

#connect to mysql user name;
USERNAME=$1;

#connect to mysql user password;
PASSWD=$2;

#connect to mysql data ip;
DATAIP=$3;
SQL_DUMP=./sql.dump;
SQL_OUTPUT=./sql.script;

echo "=======================    Intercept sql     ======================";
echo "= 1.Intercept mysql with sql statement                            =";
echo "= 2.Intercept mysql with sql script file                          =";
echo "===================================================================";
echo "please enter param: \c";
read param;

#mysql -u$USERNAME -p$PASSWD -e "select * from snz_address_factory" $DATABASE

# check intercetp sql jobs
case $param in
1) echo "please enter sql script"
   read SQL_STATE;;
*) echo "UnKnow param {$param}"
esac

# do mysql script jobs
if [[ -n $DATAIP ]]; then
mysql -u$USERNAME -p$PASSWD -h $DATAIP <<EOF>$SQL_DUMP
	$SQL_STATE
EOF

else
mysql -u$USERNAME -p$PASSWD <<EOF>$SQL_DUMP
	$SQL_STATE
EOF
fi

#write sql script head info;
echo "please enter sql script head:"
read sqlHead;

#count dump file line num;
endLine=`cat $SQL_DUMP | wc -l`

#every dump file column number;
columns=`awk '{if(NR==2) printf NF}' $SQL_DUMP`

#if file exist remove
if [ -f "$SQL_OUTPUT" ]; then 
	rm $SQL_OUTPUT;
fi

# analyze sql result, set sql value to new sql script;
echo $sqlHead >> $SQL_OUTPUT;
num=0;
cat $SQL_DUMP | while read line
do
	if [[ num -ne 0 ]]; then
		echo "(\c" >> $SQL_OUTPUT;

		# analyze every dump sql file columns
		col=0;
		for item in $line
		do
			col=$col+1;
			if [[ $columns -eq $col ]]; then
				#the end column
				echo \'$item\'"\c" >> $SQL_OUTPUT;
			else
				#every column
				echo \'$item\'",\c" >> $SQL_OUTPUT;
			fi
		done

		#if the end line
		if [[ $(($endLine-1)) -eq num ]]; then
			echo ");" >> $SQL_OUTPUT;
		else
			echo ")," >> $SQL_OUTPUT;
		fi
	fi
	num=$num+1;
done

echo "sql script create success, output sql file-> ./sql.script!"

