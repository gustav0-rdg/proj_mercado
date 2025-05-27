import mysql.connector

class Connection():

    def create():
        connection = mysql.connector.connect(
            host="127.0.0.1",
            port=3306,
            user="root",
            password="root",
            database="db_mercado"
        )
        return connection