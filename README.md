# README

# Rales Engine

Rales Engine is an API that exposes a database with customer, merchant, sales information.

## Getting Started

After cloning down the repo, please follow the instructions for installing and seeding the database.

### Prerequisites


```
Ruby 2.4.1
```

### Installing

Setup

Run Bundle

```
bundle install
```

Load the DB Schema

```
rake db:schema:load
```

Seed the database

```
rake import:all
```

## Running the tests

Simply run rspec in the root folder of the project via console.

```
rspec
```

## Deployment

Rales Engine is currently not deployed.

## Built With

* [Ruby on Rails](http://rubyonrails.org/)

## Database

* [image](https://files.slack.com/files-pri/T029P2S9M-F5MJHL1LN/pasted_image_at_2017_05_31_03_47_pm.png)

## Authors

* **Mason Holland**
* **Ellen Cooper**
