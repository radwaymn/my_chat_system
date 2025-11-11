# README


to run with docker:

1- in file: config\database.yml
make sure => host: db

2- add .env file containing DB_PASSWORD

3- run the following commands in order:<br>
docker-compose build<br>
docker-compose up -d<br>
docker-compose run web rails db:create<br>
docker-compose run web rake db:migrate<br>

4- run rails c:<br>
Message.\_\_elasticsearch\_\_.create\_\_index!(force: true)


#######################################################

To run the project locally:

pre step:
in rails c:
Message.\_\_elasticsearch\_\_.create\_\_index!(force: true)

1- in file: config\database.yml
make sure => host: <%= ENV.fetch("DB_HOST") { "127.0.0.1" } %>

2- add .env file containing DB_PASSWORD

3- create the database:<br>
rails db:create

4- start the server:<br>
rails s
