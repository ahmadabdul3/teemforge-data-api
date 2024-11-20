# README

- if theres no ruby version defined in the `.ruby-version` file, terminal
defaults to the system ruby version (instead of the rbenv version)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 3.2.2

* System dependencies

* Configuration

* Database creation

after installing postgres run:

`createdb` to create default postgres db

then create an admin user:
CREATE ROLE "teemforge-data-api" WITH LOGIN SUPERUSER PASSWORD 'teem-forge.22.xy_z';

to delete the user:
DROP ROLE "teemforge-data-api";

to create the user/role and grant priveleges

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
