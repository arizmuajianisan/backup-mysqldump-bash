# Mysqldump In Bash
Mysql dump using bash with git-bash

## How To
For localhost, change with preference that used.
```
#!/bin/bash
HOST=localhost # if perform backup from network, this should be change
USER=root # this user for localhost, if connect from network this should change
PASSWORD=root
DATABASE=stop_time_app # database origin
```

Create SQL file with time created and create log file.
```
DB_FILE=LOGdumpBackup-`date +%m-%d-%Y-%H-%M-%S`.sql
LOG=logBackup.txt
```

## Exclude Tables
If there is tables that wanted to backup, this will create list tables that ignored when dump process.
```
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
```

## Structure Dumping
First, it will dumping the complete structure database, into filename DB_FILE at folder backup_db 
```
echo "Dump structure"
D:\\laragon\\bin\\mysql\\mysql-5.7.24-winx64\\bin\\mysqldump.exe --host=${HOST} --user=${USER} --password=${PASSWORD} --single-transaction --no-data --routines ${DATABASE} > 'backup_db'/${DB_FILE}
```

## Content Dumping
After dumping structure is completed, the data will be dumping with excluded tables.
```
echo "Dump content"
D:\\laragon\\bin\\mysql\\mysql-5.7.24-winx64\\bin\\mysqldump.exe --host=${HOST} --user=${USER} --password=${PASSWORD} ${DATABASE} --no-create-info --skip-triggers ${IGNORED_TABLES_STRING} >> 'backup_db'/${DB_FILE}
```