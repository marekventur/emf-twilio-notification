import db

db.start();

print db.queryOne('select * from test')

