# Workshift Website
[![Code Climate](https://codeclimate.com/github/bsc-networks/workshift-website/badges/gpa.svg)](https://codeclimate.com/github/bsc-networks/workshift-website)
[![Build Status](https://travis-ci.org/bsc-networks/workshift-website.svg?branch=master)](https://travis-ci.org/bsc-networks/workshift-website)

A new workshift website, created by students of CS169.

###Authors
* Elliott Ison
* Joel Graycar
* Shirley Trinh
* Minh Daole
* Neil Purohit
* Stephanie Kim

Interview: http://youtu.be/-cVOpNlQUPs

# Installation
###Local
In order to install the project to be run on your computer (Development/Debug) you need to install ruby, the actual verion used by the project is ruby-2.2.2 and postgresSQL Server running on your computer.

Then, within the project directory :
  - Install Bundler
```
$ gem install bundler
```
  - Install project dependencies
```
$ bundle install
```
  - Setup the db (Create database, tables, applies migrations and use the seed.rb file)
```
$ rake db:setup
```
  - Run the server
```
$ bin/rails server
```

###Docker
In order to run the project inside a Docker container, you must install docker and docker-compose on your machine.
https://www.docker.com + https://docs.docker.com/compose/
! You Do Not Need Ruby, Rails or Postgres Server installed on your machine

Then, within the project directory :
```
# First installation

$ docker-compose build
$ docker-compose run web rake db:setup

# Container startup

$ docker-compose up
```

Docker compose will create the server container and the database container, link them together and start all the needed services.
In order to export and restore the DB, please refer to https://registry.hub.docker.com/_/postgres/
