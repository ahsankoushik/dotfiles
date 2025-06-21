
#!/bin/bash

DATABASE_DIR="/mnt/koushik/koushik"  # make sure it ends with /
MYSQL_USER="root"
MYSQL_PASSWORD="1nLKgLZSttf4Q6vWPzevc90XDxqoKrBL"

# Create backup dir if not exists
mkdir -p "$DATABASE_DIR"

# List databases, skipping system databases
mysql --user="$MYSQL_USER" --password="$MYSQL_PASSWORD" -N -e "SHOW DATABASES" |
grep -Ev "^(information_schema|performance_schema|mysql|sys)$" |
while read -r dbname; do
    echo "Dumping database: $dbname"
    mysqldump \
        --user="$MYSQL_USER" \
        --password="$MYSQL_PASSWORD" \
        --complete-insert \
        --routines \
        --triggers \
        --single-transaction \
        "$dbname" > "${DATABASE_DIR}${dbname}.sql"
done

