# ZombieBattleground::Api

[![Gem Version](https://badge.fury.io/rb/zombie_battleground-api.svg)](https://badge.fury.io/rb/zombie_battleground-api)
[![Build Status](https://travis-ci.org/watmin/zombie_battleground-api.svg?branch=master)](https://travis-ci.org/watmin/zombie_battleground-api)
[![Coverage Status](https://coveralls.io/repos/github/watmin/zombie_battleground-api/badge.svg?branch=master)](https://coveralls.io/github/watmin/zombie_battleground-api?branch=master)

[Challenge Accepted])https://medium.com/loom-network/https-medium-com-loom-network-introducing-zombie-battleground-public-api-600-pack-giveaway-859fea0dc406)

Ruby implementation of the Public API for Zombie Battleground

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zombie_battleground-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zombie_battleground-api

## Usage

See the [API documentation](https://www.rubydoc.info/gems/zombie_battleground-api/0.3.0).
Every API call returns a response object that contains a complete modeled Ruby object of the response.

Use the singleton class `ZombieBattleground::Api`

```ruby
require 'zombie_battleground/api'

ZombieBattleground::Api.decks_request(limit: 1)
# => ZombieBattleground::Api::Responses::GetDecksResponse

ZombieBattleground::Api.decks(limit: 1)
# => [ZombieBattleground::Api::Models::Decks]
```

Use the API client directly

```ruby
require 'zombie_battleground/api/client'

client = ZombieBattleground::Api::Client.new

client.decks_request(limit: 1)
# => ZombieBattleground::Api::Responses::GetDecksResponse

client.decks(limit: 1)
# => [ZombieBattleground::Api::Models::Decks]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

You can also execute `docker-compose build && docker-compose run zombie_battleground-api` to run within a Docker container that drops into a Pry session to experiment with (this is how I have developed this gem).

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/watmin/zombie_battleground-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ZombieBattleground::Api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/watmin/zombie_battleground-api/blob/master/CODE_OF_CONDUCT.md).
