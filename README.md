# Cat Clue

#### Epicodus: Ruby Course: Group Project Week of Jul 23rd - July 26

## Description

A recreation of the classic game 'Clue' using Ruby, Sinatra, and ActiveRecord

## My Contribution

I built the seed file for the psql database which populates the database with the board game spaces, rooms, and doorways, as well as weapon, player, and room cards.

I worked on the card functionality - creating the 'murder mystery', dealing the cards to players, displaying player cards, and displaying one of the correct card guesses. I also built the routes for the application and helped with player piece movement on the board.

### Installing

Complete the steps below to clone the project on to your personal machine and get the application running.

Clone the repo from github to your machine

```
git clone https://github.com/reeseglasscock/cat-clue.git
```

Make sure that you have postgres installed on your machine. You can run bundle (if you have bundler) to install all gems on your machine

```
bundle install
```

You will then need to create the databases locally on your system.

```
rake db:migrate
```

## Setup Requirements


To run the application you will now need to have sinatra also installed on your system. You can then go to the project folder within terminal and run the command below to have the project start

```
ruby app.rb
```

Lastly point your web browser to localhost port 4567 to open the project.

```
open http://localhost:4567
```

## Deployment

Additionally you can deploy this code to your own app on Heroku.com for free. You can check out a live app by going to https://cat-clue.herokuapp.com/. You can also find documentation for how to deploy your app on the Heroku website.

## Technologies Used

* [Ruby](https://www.ruby-lang.org/en/news/2018/03/28/ruby-2-5-1-released/) - 2.5.1
* [Postgres](https://www.postgresql.org/) - 1.0.0
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html) - 5.2.0
* [Sinatra](http://sinatrarb.com/) - 2.0.3

## Database Schema
![image](https://user-images.githubusercontent.com/11031915/43095872-170dddaa-8e6c-11e8-946c-105e3b1ad153.png)

## Authors

* **Reese Glasscock** [Github](https://github.com/reeseglasscock)
* **Nate Cottle**
* **Annie Shin**
* **Rita Bennett-Chew**

### MVP User Stories
* Exactly 4 human players will take turns to guess the details of the Murder

## License

This software is licensed under the MIT license.

Copyright (c)2018 ** Reese Glasscock, Nate Cottle, Annie Shin, Rita Bennett-Chew**
