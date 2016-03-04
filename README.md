# coop-workshift-app
CS 169 Group Project, Spring 2016. An application to manage the assignment and management of work shifts in the BSC (Berkeley Student Cooperative) system.

Code Climate:

<a href="https://codeclimate.com/github/rails/rails"><img src="https://codeclimate.com/github/rails/rails/badges/gpa.svg" /></a>

Travis CI:
[![Build Status](https://travis-ci.org/momochanfitz/coop-workshift-app.svg?branch=master)](https://travis-ci.org/momochanfitz/coop-workshift-app)

Pivotal Tracker:
https://www.pivotaltracker.com/projects/1545105

##Resources

[Old Site](https://workshift.bsc.coop/clo/online_signoff.php)
[Workshift CSV Example](https://docs.google.com/spreadsheets/d/1zQl654nTXGvvZmO-40sK2LHi5gkv7dh4WgdVn6jrNa4/edit#gid=0)

##Heroku

*__Site__: [Home page here](https://coop-workshifts.herokuapp.com/login)
*Adding your remote: `heroku git:remote -a coop-workshifts`
    *Make sure you're logged in `heroku login` on cloud9 and are a contributer to the app (Alex should have added you)
*Checking the logs: `heroku logs --tail`
*Running commands on Heroku: `heroku run ...`
    *Migrating heroku schema (after pushing actual rails migration file): `heroku run bundle exec rake db:migrate`
    


##Styling

*Bootstrap-sass
    * https://github.com/twbs/bootstrap-sass
    * __Do not use *= require in Sass or your other stylesheets will not be able to access the Bootstrap mixins or variables.__


##Reminders

*Ideally pull before pushing (`git pull origin master`)
*`bundle install` after pulling

*When 