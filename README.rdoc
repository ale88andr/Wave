== WAVE
it's description for rails application called **Wave**
	demo available on  http://wa-ve.herokuapp.com/
	privileged user: *_probe*
	user password:   *Pa$$w0rd*
	
code example
  controllers (https://github.com/ale88andr/Wave/tree/master/app/controllers, "here ->")
  models (https://github.com/ale88andr/Wave/tree/master/app/models, "here ->")
  views (https://github.com/ale88andr/Wave/tree/master/app/views, "here ->")
  routes (https://github.com/ale88andr/Wave/tree/master/config/routes.rb, "here ->")
  
test example
  Rspec (https://github.com/ale88andr/Wave/tree/master/spec, "here ->")
  Cucumber (https://github.com/ale88andr/Wave/tree/master/features, "here ->")
  
== Diagram

![DB diagram](https://github.com/ale88andr/Wave/blob/master/db/Diagram_EAV.png "DB diagram")

== Ierarchy

Current directory structure of Wave

  |-- app
  |   |-- assets
  |   |   |-- images
  |   |   |-- javascripts
  |   |   `-- stylesheets
  |   |-- controllers
  |   |-- helpers
  |   |-- mailers
  |   |-- models
  |   |-- presenters
  |   |   |-- general
  |   |   `-- manufacturers
  |   `-- views
  |       `-- layouts
  |-- config
  |   |-- environments
  |   |-- initializers
  |   `-- locales
  |-- db
  |-- doc
  |-- features
  |   |-- step_definition
  |   `-- support
  |-- lib
  |   |-- assets
  |   `-- tasks
  |-- log
  |-- public
  |-- script
  |-- spec
  |   |-- controllers
  |   |-- factories
  |   |-- models
  |   |-- support
  |   `-- views  
  |-- test
  |   |-- fixtures
  |   |-- functional
  |   |-- integration
  |   |-- performance
  |   `-- unit
  |-- tmp
  |   `-- cache
  |       `-- assets
  `-- vendor
      |-- assets
      |   |-- javascripts
      |   `-- stylesheets
      `-- plugins
