# twilio-sms-verification

A sample application for Twilio SMS.

### NOTE!!

SMS can be sent to real phone. Do not send it to someone you don't know.

## Setup

````
$ bundle install
$ bundle exec rake db:migrate
````

Then, set up ENV values. If you are using Pow and Powder:

````
$ cp .powenv.sample .powenv
$ vi .powenv # Write your own credentials.
$ powder link
$ powder open
````

## How to test

In RSpec, SMS will not be sent.

````
$ bundle exec rspec
````

If you like Spork and Guard:

````
$ bundle exec guard
````
