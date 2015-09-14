heroku pg:backups capture
filename=db_dump_$RANDOM
curl -o ./tmp/$filename `heroku pg:backups public-url`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d redcross_development ./tmp/$filename
rake db:migrate
