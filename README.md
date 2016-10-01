# README

## Software Dependencies
* Ruby version: 2.3.1
* System dependencies
  * Database: Postgres 9.4 or newer version
* Others
  * Rails Panel
    * There's [RailsPanel](https://github.com/dejan/rails_panel) configured for this project, for better developing experience, please install RailsPanel extension from [Chrome Webstore](https://chrome.google.com/webstore/detail/railspanel/gjpfobpafnhjhbajcjgccbbdofdckggg) .

## Setup
```shell
$ bundle install
$ cp config/application.yml.example config/application.yml
$ cp config/database.yml.example config/database.yml
$ rake db:setup
$ rake server
```
