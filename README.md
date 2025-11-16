# README

to run with docker:

1- add .env file containing DB_HOST=db, DB_PORT=3310, DB_PASSWORD

2- run the following command<br>
docker compose up --build<br>

3- run rails c:<br>
Message.\_\_elasticsearch\_\_.create\_\_index!(force: true)

to run specs:<br>
docker compose run web bundle exec rspec

#######################################################

To run the project locally:

pre step:
in rails c:
Message.\_\_elasticsearch\_\_.create\_\_index!(force: true)

1- add .env file containing DB_HOST=127.0.0.1, DB_PASSWORD

2- create the database:<br>
rails db:create

3- start the server:<br>
rails s

to run specs:<br>
rspec
