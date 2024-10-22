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
- [http://localhost:3000/]
- [http://localhost:3000/students]

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

## Adding Devise
### House keeping
We are adding things to our models, so before we even start we need to...
- rails db:truncate_all

Due to Devise storing things in our email we want to remove all of the referances to emails in our files.
- rails generate migration RemoveStudentsSchoolEmail
Then add the change to the new migration file.
- remove_column :students, :school_email, :string
db:migrate and look at schema to see the change.
We then wanna remove school_email references in the following files
- `app/models/student.rb`
- Controller - remove from student_params
- `app/views/students/_form.html.erb`
- `app/views/students/_student.html.erb`

### Installing
We then wanna add Devise to our Gem file, so in our gem file we wanna add
`# User authentication https://github.com/heartcombo/devise
gem "devise" `
Once that is added run
- bundle install
Once that is finished run
- rails generate devise:install
pay attention to what it tells you once its done.
```
  1. Ensure you have defined default url options in your environments files. Here
       is an example of default_url_options appropriate for a development environment
       in config/environments/development.rb:
         config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
       In production, :host should be set to the actual host of your application.
       * Required for all applications. *
  2.   2. Ensure you have defined root_url to *something* in your config/routes.rb.
       For example:
         root to: "home#student"
       
       * Not required for API-only Applications *
  3.  Ensure you have flash messages in app/views/layouts/application.html.erb.
       For example:
         <p class="notice"><%= notice %></p>
         <p class="alert"><%= alert %></p>
       * Not required for API-only Applications *
  4. You can copy Devise views (for customization) to your app by running:
         rails g devise:views
  From research will be doing custom views for student model below
```
First we need to go to our `config/environments/development.rb` and add... 
`config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }`
to the file to be able to have a defualt url. Then we will run...
- rails generate devise Student
...Which will create a model and route if none where there. We then shouldn't need to touch anything else.

### Configs
Now that we have it working we are able to see that they added some standard code. This is fine and shouldn't be touched for now. But need to set up email msu email verification. So we wanna add...
```
   validate :email_format
   def email_format
       unless email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
           errors.add(:email, "must be an @msudenver.edu email address")
       end
   end
```
to our `app/models/student.rb`

Once that is done we can start to edit the views. to add the views based on what we have we need to do...
- rails generate devise:views students

Once here you should be able to go to [http://localhost:3000/students/sign_up] but this won't work yet. to have it work, you must copy the fields when creating a new student from `app/views/students/_form.html.erb` into `app/views/students/registrations/new.html.erb` so the fields will be created on registration. But to work properly you must change all `form.` to `f.`.

The ApplicationController is used to define behaviors, methods, and filters that you want to apply to all controllers in your application. In order to add other parameters to the devise form you need to do the following in `app/controllers/application_controller.rb` 
```
class ApplicationController < ActionController::Base
   #configure_permitted_parameters: method runs before each Devise controller action.
   before_action :configure_permitted_parameters, if: :devise_controller?

   #protected methods in class
   protected

#override configure_permitted_parameters method to allow additional parameters
  #by default devise only allows email, password and password_confirmation
  def configure_permitted_parameters
      # parameters allowed during sign up
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :major, :minor, :graduation_date])
      # parameters that can be updated
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :major, :minor, :graduation_date])
  end

end
```
BUT TO BE ABLE TO HAVE YOUR TESTS AND SCAF TO WORK YOU MUCH CHANGE THE KEYS TO MATCH YOUR SCAFS KEYS.

Next to be able to configure your controllers you need to run...
- rails generate devise:controllers students

Need to update the `config/routes.rb` to find student/registrations form 
```
Rails.application.routes.draw do
 devise_for :students, controllers: {
 registrations: 'students/registrations',
 sessions: 'students/sessions',
 passwords: 'students/passwords'
}
```



  
