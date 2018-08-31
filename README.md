# Cat Clue

#### Epicodus: Ruby Course: Group Project Week of Jul 23rd - July 26

#### Reese Glasscock, Nate Cottle, Annie Shin, Rita Bennett-Chew

## Description

A recreation of the classic game 'Clue' using Ruby, Sinatra, and ActiveRecord

## My Contribution

I built the seed file for the psql database which populates the database with the board game spaces, rooms, and doorways, as well as weapon, player, and room cards.

I worked on the card functionality - creating the 'murder mystery', dealing the cards to players, displaying player cards, and displaying one of the correct card guesses. I also built the routes for the application and helped with player piece movement on the board.

## Setup Requirements

1. Clone the repo
1. Delete Gemfile.lock
1. Run '$bundle install' to bundle Gemfile dependencies
1. Create the database environments using '$rake:db create'
1. Recreate the database using '$rake:db migrate'
1. Install the game database by running '$rake db:seed'
1. Deploy app locally by running '$ruby app.rb'

## Technologies Used

* Ruby 2.4.1
* Postgresql and psql
* ActiveRecord

## Database Schema
![image](https://user-images.githubusercontent.com/11031915/43095872-170dddaa-8e6c-11e8-946c-105e3b1ad153.png)

## User Stories
### MVP User Stories
* Exactly 4 human players will take turns to guess the details of the Murder

## License

This software is licensed under the MIT license.

Copyright (c)2018 ** Reese Glasscock, Nate Cottle, Annie Shin, Rita Bennett-Chew**
