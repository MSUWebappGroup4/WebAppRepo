# Documentation
## Running the Webapp
From your computer you need to make a docker image of in the CS3710_Docker Image_Files. You will need to follow the steps below to start up the app.
- cd 'YOUR FILE PATH\CS3710_Docker Image_Files'

If you did not build your enviornment, WHILE DOCKER IS OPEN... 
- docker build -t [DOCKER USERNAME]/[IMAGE NAME] .
- docker run -it -p 3000:3000 -v ${PWD}:/workspace [DOCKER USERNAME]/[IMAGE NAME]
- #cd portfolio_app
- #ruby --version (This is to check if you are up to date.)
- #rails --version (This is to check if you are up to date.)
- move to next steps...

If you are built...
- docker ps -a
- docker restart <container_id_name>
- docker exec -it <container-id> bash

[laughing_bhaskara]

Starting the server in the container...
- #rails server -b 0.0.0.0

If sever does not close got to `WebAppRepo\CS3710_Docker Image_Files\WebApp\tmp\pids` there should be a server file, in the server file there should be a number
- kill server (Number in Server)

While the server is running you can use the following links to navigate the webapp
- http://localhost:3000/
- http://localhost:3000/students

## Active Storage
Using the rails documentation from https://guides.rubyonrails.org/active_storage_overview.html

Using Active Storage, an application can transform image uploads or generate image representations of non-image uploads like PDFs and videos, and extract metadata from arbitrary files.

To set up the active storage...
- #bin/rails active_storage:install
- #bin/rails db:migrate

## Scaf
To change scaffolding and remake data scafolds you can use the following commands...

-# rails generate scaffold [Name of scaffold] [NAME:DATA TYPE]
- Generates controller for the DB, +DB table with each added variable. YOU MUST follow up with db migrate.
-# rails destroy scaffold [Name of scaffold]
- Destroy the scaffold that you named.


## Testing
Behavior-driven design (BDD)
- develop user stories (the features you wish you had) to describe how app will work
- user stories become acceptance tests and integration tests

Test-driven development (TDD)
- step definitions for new story
- TDD says: write unit & functional tests for that code first, before the code itself
- that is: write tests for the code you wish you had

## Models

## Views

## Controllers


