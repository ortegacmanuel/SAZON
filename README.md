# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# CAV
# SAZON


## Run the tests with:

``
bundle install
rails RACK_ENV=test db:create
rails RACK_ENV=test db:schema:load
bundle exec rspec
``
