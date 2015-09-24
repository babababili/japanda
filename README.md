# Japanda

Japanda provides an object-oriented wrapper and functional wrapper around Instructure Canvas Api's

Disclaimer: For testing purposes only.

v0.1.3 Features

1. Create canvas learner user and admin user
2. Create canvas course
3. Add sections to canvas
4. Add module(s) with assignment(s)

## Installation

Add this line to your application's Gemfile:

    gem 'japanda'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install japanda

## Usage

Set a few enviroment variables( or use .env.example file)

    export CANVAS_API_HOST=
    export CANVAS_API_TOKEN=
    export CANVAS_ACCOUNT_ID=

To create a new course

    CanvasFactory::Course.new
    
To create a canvas course by specifying the course config

    course_config = CanvasFactory::CourseConfig.new({ name: 'Candy Tasting' })
    course = CanvasFactory::Course.new course_config
    
To create a canvas learner user

    user_config = CanvasFactory::UserConfig.new(short_name: 'John Doe', password: 'Password01') 
    user = CanvasFactory::User.new(user_config)
    learner_user = user.create_learner_user

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests.
To install this gem onto your local machine, run `bundle exec rake install`.

## Release a new version

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/babababili/japanda. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

For testing purposes only.

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
