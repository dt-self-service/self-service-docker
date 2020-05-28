# self-service-docker
> Standalone docker-compose, app and default configs for deploying self-service-app with nginx and postgres.

## Table of contents
* [General info](#general-info)
* [Screenshots](#screenshots)
* [Technologies](#technologies)
* [Setup](#setup)
* [Features](#features)
* [Status](#status)
* [Credit](#credit)
* [Contact](#contact)

## General info
This repo contains an example configuration that **REQUIRE CHANGES**.
Please copy the contents of app/config_template to app/config directory. Be sure to go through each config.
The sections in settings.py that need to be adjust are labelled with #CHANGEME.
Copy the .env.template files to .envs and update the variable values as needed.

## Screenshots
![Login](https://github.com/dt-self-service/self-service-app/blob/master/screenshots/login.PNG)
![Dashboard](https://github.com/dt-self-service/self-service-app/blob/master/screenshots/dashboard.PNG)
![Create Maintenance Window](https://github.com/dt-self-service/self-service-app/blob/master/screenshots/create-mwindow.PNG)

## Technologies
* Python 3.8+
* Django
* Docker
* nginx
* Bootstrap
* PostgreSQL

## Setup
> ### Prerequisites:
>
> - Docker

1. Clone the latest version of the self-service-docker application:

> `git clone git@github.com:dt-self-service/self-service-docker.git`

2. Switch into the application's directory:

> `cd self-service-docker/app/`

3. Edit django.template.env using your favorite editor to configure admin and host and save it as django.env:

> `vim django.template.env`

> `:wq! django.env`

4. Edit db.template.env using your favorite editor to configure database user and password db.env:

> `vim db.template.env`

> `:wq! db.env`

5. Switch into the config_template directory and edit user_variables.py to connect to your Dynatrace environment:

> `cd config_template`

> `vim user_variables.py`

6. Edit settings.py to configure SMTP settings at the bottom of the file:

> `vim settings.py`

7. Copy everything in this folder into ../config

> `cp -r * ../config`

8. *OPTIONAL: Configuring SSO - Switch into the config folder and configure SAML inside settings.json*

9. Switch back to the root of the project and start the services using docker-compose:

> `docker-compose up -d`

10. *OPTIONAL: To change the default ports the applications runs on you can change it in docker-compose.yml*

11. Using your browser navigate to your host https://<HOST>:8443 and login using the admin account you created.
  
## Features
* Maintenance Windows
* Local Authentication
* SSO
* Requests Logging for Auditing

To-do list:
* Filter Down Views based on Permissions in Dynatrace
* Install Wizard
* Alerting Profiles
* Problem Notification Integration

## Status
Project is: _in progress_

## Credit
Special thanks to Joe Nguyen for developing test cases for this project!

## Contact
Created by George Teodorescu and Aaron Philipose - feel free to contact us!
