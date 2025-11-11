# README

#######################################################

to run with docker:

1- in file: config\database.yml
make sure => host: db

2- add .env file containing DB_PASSWORD

3- run the following commands in order:
docker-compose build
docker-compose up -d
docker-compose run web rails db:create
docker-compose run web rake db:migrate

4- in rails c:
Message.**elasticsearch**.create*index!(force: true)
please replace \* with *

#######################################################

To run the project locally:

pre step:
in rails c:
Message.**elasticsearch**.create_index!(force: true)

1- in file: config\database.yml
make sure => host: <%= ENV.fetch("DB_HOST") { "127.0.0.1" } %>

2- add .env file containing DB_PASSWORD

3- in termial (for first time only):
rails db:create

4- in terminal:
rails s
