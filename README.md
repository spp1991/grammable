# Grammable 

This application allows users to create/edit/destroy post and allows users (including the user who created the post) to submit comment on the post. Each user is required to sign up before taking any action (create/edit/destroy post, post a comment)

This application was developed using test driven development approach which allows developer to ensure that application functionalities are working before any new code changes are commited . Rspec gem is used to develop test for the application and AWS cloud storage platform is used to store images associated with each post.

## [Try it yourself](https://grammable-sunnypatel.herokuapp.com/) 


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

You will need to setup Vagrant environment to run the application on local machine. To find the installation instructions for your OS, visit :

```
https://github.com/FirehoseProject/firehose-vagrant-rails5
```
### Installing

Initiate the vagrant environment.

Git clone the repository to your local machine in the src folder :

HTTPS:
```
$ git clone https://github.com/spp1991/grammable.git
```

SSH:

```
$ git clone git@github.com:spp1991/grammable.git
```

Open application folder created by git clone command:

```
$ cd grammable
```

Install all the gems used in application:

```
$ bundle install
```

Install the application database and create all the tables:

```
$ rails db:create
$ rails db:migrate
```

You will then be able to start the app locally by runnning:

```
$ rails server -b 0.0.0.0 -p 3000
```

## Built With

* [Ruby on Rails](https://rubyonrails.org/) - Web framework
* [PostgreSQL](https://www.postgresql.org/) - Database
* [HTML5](https://en.wikipedia.org/wiki/HTML5) - Web markup language
* [CSS3](http://www.css3.info/) - Webpage Style Sheet language
* [Bootstrap](https://getbootstrap.com/) - CSS Framework
* [Javascript](https://www.javascript.com/) - Web Programming language
* [jQuery](https://jquery.com/) - Javascript Framework
* [Amazon Web Service](https://aws.amazon.com/) - Cloud Storage Platform
* [Carrierwave](https://github.com/carrierwaveuploader/carrierwave), [Fog-aws](https://github.com/fog/fog-aws), [devise](https://github.com/heartcombo/devise), [rSpec](https://rspec.info/), [factorybot](https://github.com/thoughtbot/factory_bot) - Ruby gems

## Home Page
<img src="screenshot-1.png" alt="Screenshot">

## New Gram Page
<img src="screenshot-2.png" alt="Screenshot">

