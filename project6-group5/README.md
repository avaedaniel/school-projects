* Ruby version
    3.4.1

* System dependencies

    Make sure Ruby and rails are installed in the machine

* Configuration

    This file is used by Rack-based servers to start the application.

    require_relative "config/environment"

    run Rails.application
    Rails.application.load_server

* Database creation

    If this is the first time one launch the server, run the following command before starting rails server: 

    rails db:migrate

* Deployment instructions

    If this is the first time one launch the server, run the following commands in provided order:

        bundle install

        bundle update

        rails s

    Please also make sure to launch the server from Ava branch

* Work Distribution

    Yoyi
        - initial set up of the project
        - index pages
        - small fixes here and there

    Ava
        - Header
        - Footer
        - Added edit and delete button to all index page
        - settlement

    Ryan
        - Debt calculation
        - CSS styling

    Jia-Hui
        - Formated layout of user table, trip table, user information and trip information 
        - fixed expenses section
