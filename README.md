[![Build Status](https://travis-ci.org/moneydesktop/protobuffness.svg?branch=master)](https://travis-ci.org/moneydesktop/protobuffness)
[![Code Climate](https://codeclimate.com/github/moneydesktop/protobuffness/badges/gpa.svg)](https://codeclimate.com/github/moneydesktop/protobuffness)
[![Test Coverage](https://codeclimate.com/github/moneydesktop/protobuffness/badges/coverage.svg)](https://codeclimate.com/github/moneydesktop/protobuffness)

# Protobuffness

This is an attempt to make a pure ruby implementation of protobuf serialization and de-serialization.

We borrow a lot from [Localshred's Protobuf](https://github.com/localshred/protobuf) implementation, with the main differences being:

* De-couple the serialization logic from RPC logic
* Generate complete classes during protobuf compilation rather than defining methods at runtime

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/protobuffness/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
