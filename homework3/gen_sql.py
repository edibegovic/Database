import psycopg2
import itertools

conn = psycopg2.connect(host="localhost",database="homework3", user="postgres", password="postgres")

def fd_q(f, t, table):
    return "SELECT '" + table + ": " + f + " --> "+ t +"' AS FD, CASE WHEN COUNT(*)=0 THEN 'MAY HOLD' ELSE 'does not hold' END AS VALIDITY FROM (SELECT "+f+" FROM "+table+" GROUP BY "+f+" HAVING COUNT(DISTINCT "+t+") > 1 ) X;"

queries = []

boats = ["bl", "bno", "z", "t", "bn", "ssn"]
rentals = ["pid", "hid", "pn", "s", "hs", "hz", "hc"]

for i, j in itertools.product(rentals, rentals):
    if(i != j):
        queries.append(fd_q(i, j, "rentals"))

curs = conn.cursor()
for q in queries:
    curs.execute(q)
    for row in curs:
       print (row)


# Boats: 
# z -> bl
# z -> t

# Rentals:
# pid -> pn
# hid -> hs
# hid -> hz
# hid -> hc
# hz -> hc
