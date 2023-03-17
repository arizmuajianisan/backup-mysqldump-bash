#!/bin/bash
HOST=localhost # if perform backup from network, this should be change
USER=root # this user for localhost, if connect from network this should change
PASSWORD=root
DATABASE=stop_time_app # database origin
DB_FILE=LOGdumpBackup-`date +%m-%d-%Y-%H-%M-%S`.sql # expected output file name of exported Db file, with date
LOG=logBackup.txt # to create the log file
EXCLUDED_TABLES=(
t11411_pending_mps
t11412_pending_mps
t11421_pending_mps
t11422_pending_mps
t114_pending_mps
)

# Create list to EXCLUDED_TABLES
IGNORED_TABLES_STRING=''
for TABLE in "${EXCLUDED_TABLES[@]}"
do :
    IGNORED_TABLES_STRING+=" --ignore-table=${DATABASE}.${TABLE}"
done

echo "..........BACKUP STARTED.........."
echo "Started backup on `date +%m-%d-%Y-%H-%M-%S`"
echo "Started on `date +%m-%d-%Y-%H-%M-%S`" >> 'backup_db/log'/${LOG}
# Create structure of origin database, then store it to folder backup_db
echo "Dump structure"
D:\\laragon\\bin\\mysql\\mysql-5.7.24-winx64\\bin\\mysqldump.exe --host=${HOST} --user=${USER} --password=${PASSWORD} --single-transaction --no-data --routines ${DATABASE} > 'backup_db'/${DB_FILE}

# Create dump database to sql file named DB_FILE in folder backup_db
echo "Dump content"
D:\\laragon\\bin\\mysql\\mysql-5.7.24-winx64\\bin\\mysqldump.exe --host=${HOST} --user=${USER} --password=${PASSWORD} ${DATABASE} --no-create-info --skip-triggers ${IGNORED_TABLES_STRING} >> 'backup_db'/${DB_FILE}

echo ".........BACKUP FINISHED........."
echo "Finished backup on `date +%m-%d-%Y-%H-%M-%S`"
echo "Backup Process Finish on `date +%m-%d-%Y-%H-%M-%S`" >> 'backup_db/log'/${LOG}
