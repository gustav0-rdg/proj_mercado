import mysql.connector

class Connection():

    def create():
        connection = mysql.connector.connect(
            host="disco-magico-gustavor0d-disco-magico-gustavo.c.aivencloud.com",
            port=13935,
            user="avnadmin",
            password="AVNS_UjqarbEi4gwkBWadktR",
            database="db_mercado"
        )
        return connection