from __future__ import print_function

import cx_Oracle

connection = cx_Oracle.connect("na17a013","txtAAC0I","sme-oracle.sme.utc/nf26")

cursor = connection.cursor()
cursor.execute("""
	    SELECT *
	    FROM categorie""",)
for nom in cursor:
	print("Values:", nom)

