# src/bash/qto/funcs/backup-postgres-table.func.sh

# ---------------------------------------------------------
doBackupPostgresTable(){

   mkdir -p $product_instance_dir/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/tmp
   dump_file=$product_instance_dir/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/tmp/$tables.data.sql

	doLog "DEBUG START doBackupPostgresTable"
   echo "start running : pg_dump  --verbose --data-only --table public.$tables $postgres_db_name "
   echo -e "\n --file $dump_file \n"

   pg_dump  --verbose --data-only --table public.$tables $postgres_db_name \
      --file $dump_file
   echo "stop running : pg_dump  --verbose --data-only --table public.$tables $postgres_db_name \\"
   echo -e " --file $DataDir/tmp/$tables.data.sql \n"

   doLog "INFO produced the following file : $(ls -1 $dump_file)"
   doLog "INFO with the following amount of lines :"
   wc -l $dump_file
   echo -e "\n\n"
	doLog "DEBUG STOP  doBackupPostgresTable"
}

# eof file: src/bash/qto/funcs/backup-postgres-table.func.sh