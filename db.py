import psycopg2
import config

conn = None

def start():
    global conn
    conn = psycopg2.connect(config.db_connection_string)

def query(sql, params=()):
    cur = conn.cursor()
    cur.execute(sql, params)
    result = cur.fetchall()
    cur.close()
    return result

def queryOne(sql, params=()):
    return query(sql, params)[0]


