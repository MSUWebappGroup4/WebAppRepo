## Documentation
# Running the Webapp
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

[laughing_bhaskara]

Starting the server in the container...
- #rails server -b 0.0.0.0

While the server is running you can use the following links to navigate the webapp
- http://localhost:3000/
- http://localhost:3000/students

