# Expression Evaluator
Check and Evaluate valid mathmetical expression and return result into fraction numbers

# Pre-requisites
* Ruby 2.6.1/2.7.4/3.0.2
* Rake

# How to run the code
 
* `git clone https://github.com/chakgopal/Expression_Checker.git`
 * `bundle install`
 * We will execute the program using the command `rake`



Create a Rakefile with a `default task`. The rake file should import the `main` ruby file, which is the starting point of your application and the call the main method within the `default task`. Also create a `Gemfile` to add your dependencies, if any. The `main file` should read the input and then execute the program.



 # How to execute the unit tests

 
 The unit tests to be in folder

* spec

In your Rakefile add the RSpec task.

`RSpec::Core::RakeTask.new(:spec)`

run the unit tests and with command
rspec

