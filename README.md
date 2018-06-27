# SharedTimecop

[![Build Status](https://travis-ci.org/a2ikm/shared_timecop.svg?branch=master)](https://travis-ci.org/a2ikm/shared_timecop)

Timecop wrapper to share timetravel in multi processes.

**NOTE** Currently only `Rails.cache` store is supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shared_timecop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shared_timecop

## Usage

```ruby
SharedTimecop.store = :rails_cache

SharedTimecop.freeze(1.year.ago)

SharedTimecop.go do
  # Here is 1 year ago
end

SharedTimecop.go
# Here is also 1 year ago
SharedTimecop.return

SharedTimecop.reset

SharedTimecop.go do
  # Here is NOT 1 year ago
end
```

Note that this gem is not thread-safe because Timecop is not.

### Rack Middleware

`SharedTimecop::RackMiddleware` is a Rack middleware to run an application within `SharedTimecop.go` block.

If you are building an Rails application, write this code in `config/application.rb` or so.
Then all requests are processed within `SharedTimecop.go {}` block.

```
config.middleware.unshift SharedTimecop::RackMiddleware
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/a2ikm/shared_timecop.
