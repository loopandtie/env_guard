# EnvGuard

Gem that makes it easy to guard your entire application with basic authentication.
Useful when you don't want to make staging public.

It essentially performs the following:

```ruby
before_action :basic_authenticate, if: :application_flagged_for_guarding?
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'env_guard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_guard

## Usage

Include in ApplicationController and set the before_action:

```ruby
class ApplicationController < ActionController::Base
  include EnvGuard

  before_action :guard_environment, if: :environment_guard_flags?

  # Conceptually, guard_environment equates to
  # authenticate_or_request_with_http_basic username: ENV['ENVGUARD_USERNAME'], password: ENV['ENVGUARD_PASSWORD']
end
```

Then be sure to set the ENV variables `ENVGUARD_USERNAME` and `ENVGUARD_PASSWORD`
only if you want that environment guarded with basic auth.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dimroc/env_guard.

