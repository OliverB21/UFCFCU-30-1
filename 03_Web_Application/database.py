import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

databaseUsername = os.getenv('DB_USERNAME')
databasePassword = os.getenv('DB_PASS')

dbConnectionString = f'mysql+pymysql://{databaseUsername}:{databasePassword}@aws.connect.psdb.cloud/oliverinvoices?charset=utf8mb4'

# Create a connection to the database
engine = create_engine(dbConnectionString,
                       connect_args={'ssl': {
                           "ssl_ca":"/etc/ssl/cert.pem"}})

with engine.connect() as connection:
    result = connection.execute(text('SELECT * FROM invoices'))
    for row in result:
        print(type(row))
