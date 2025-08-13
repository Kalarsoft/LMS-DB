import os
import psycopg
from dotenv import load_dotenv
import sql_statements

load_dotenv()

db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')

def create_tables(cur):
    cur.execute(sql_statements.collection_item_table_creation)
    cur.execute(sql_statements.patron_table_creation)
    cur.execute(sql_statements.staff_table_creation)
    cur.execute(sql_statements.library_table_creation)
    cur.execute(sql_statements.library_collection_table_creation)
    cur.execute(sql_statements.on_hold_item_table_creation)
    cur.execute(sql_statements.checked_out_item_table_creation)
    cur.execute(sql_statements.late_item_table_creation)
    cur.execute(sql_statements.lost_item_table_creation)
    cur.execute(sql_statements.foreign_key_creation)

def insert_data_into_table(cur, table_name):
    # TODO
    pass

def main():
    with psycopg.connect(f'dbname={db_name} user={db_user} password={db_password}') as conn:
        with conn.cursor() as cur:
            create_tables(cur)

if __name__ == "__main__":
    main()