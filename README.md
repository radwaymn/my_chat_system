# README

pre step:
in rails c:
Message.**elasticsearch**.create_index!(force: true)

To run the project locally:
1- add .env file containing DB_PASSWORD

2- in termial (for first time only):
rails db:create

3- in terminal:
rails s
