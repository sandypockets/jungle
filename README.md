# Jungle

A mini ecommerce application, built with Rails 4.2. The purpose of this app was to become more familiar with Rails, and working with an existing codebase. 

![https://github.com/sandypockets/jungle/blob/master/docs/jungle-demo-screenshot.png?raw=true](https://github.com/sandypockets/jungle/blob/master/docs/jungle-demo-screenshot.png?raw=true)

## Getting Started

#### Additional Steps for Apple M1 Machines
If you're on an M1, follow these steps before completing `Setup`. If you're not on an M1, proceed on down to `Setup` to get started.

1. Make sure that you are running Ruby 2.6.6 (`ruby -v`)
1. Install ImageMagick `brew install imagemagick imagemagick@6 --build-from-source`
2. Remove Gemfile.lock
3. Replace Gemfile with version provided [here](https://gist.githubusercontent.com/FrancisBourgouin/831795ae12c4704687a0c2496d91a727/raw/ce8e2104f725f43e56650d404169c7b11c33a5c5/Gemfile)

### Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create a new `.env` file based on `.env.example`
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate `.env` vars
8. Run `bin/rails s -b 0.0.0.0` to start the server
9. Run `bin/rake routes` as needed to check routes.

This app was developed in a Vagrant VM, where its Postgres database lives, which is why the server command in Step 8 is configured to run on `0.0.0.0`. 

### Stripe Testing

- For credit card/payment testing, use the following information:
   - `4111 1111 1111 1111` (success scenarios)
    - Any expiry date in the future
    - Any CVV
- For more testing information, or setting up failure scenarios, refer to the [Stripe Testing Docs](https://stripe.com/docs/testing#cards)

### RSpec Testing
To run an individual spec, use the `rspec` command, followed by the path of the test you want to run. 

> **Example**: `rspec spec/features/add_to_cart_spec.rb`

Most RSpecs will take a screenshot to help verify the success, using a headless browser. The screenshots can be found in `tmp/capybara/`

## Dependencies

* Ruby 2.3.5
* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

> **Note**: If you're not using `Ruby 2.3.5` and are running into challenges, consider using something like [RVM](https://rvm.io/) to adjust your version.