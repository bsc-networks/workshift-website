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
In order to install the project to be run on your computer (Development/Debug) you need to install ruby, the actual version used by the project is ruby-2.2.2 and postgresSQL Server running on your computer, but the project is much simpler to run with Docker (below).

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
In order to run the project inside a Docker container, you must install docker, docker-compose, and docker-machine on your machine. Docker allows you to create docker containers from images, docker-compose allows multiple containers to communicate, and docker-machine works with virtualbox to generate a suitable VM for docker.
https://www.docker.com + https://docs.docker.com/compose/
! You Do Not Need Ruby, Rails or Postgres Server installed on your machine

Then, within the project directory :
```
# Docker Machine Setup (first time only, with docker-machine and virtualbox installed)

$ docker-machine create --drive virtualbox <vm-name>
$ eval "$(docker-machine env <vm-name>)"

The env command pipes docker and docker-compose commands to the VM to allow interaction with the container.

On subsequent startups, run
$ docker-machine start <vm-name>
instead of create.

to stop the VM, run
$ docker-machine stop <nm-name>

# First installation

$ docker-compose build
$ docker-compose run web rake db:setup

# Container startup

$ docker-compose up

# Running Tests with RSpec
$ docker-compose run web bundle exec rspec spec
$ docker-compose run web bundle exec cucumber features --tags ~@rufus

If the specs have problems with db access or you make ActiveRecord migrations to change the db schema, be sure to repopulate the test db:
$ docker-compose run web bundle exec rake db:test:migrate
```

In order to export and restore the DB, please refer to https://registry.hub.docker.com/_/postgres/
