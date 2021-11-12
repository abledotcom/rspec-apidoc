# RSpec HTTP API Documentation 📠

Automatically generates the documentation for your HTTP API.

The idea is simple, you write the request specs, run your tests and you end
up with an HTML file with grouped examples of the request and response
examples.

## But why?

I've tried a lot of tools in the hope to solve a simple problem: automatically
generate the API documentation based on a simple RSpec request test.

Tools like Blueprint, OpenAPI Swagger are great as a concept, but either
require some DSL (aka, more work on my side huh) or these are high maintenance
if your API design requires some flexibility and rapidly evolves.

Either way, there's only one single source of truth: **your tested code**.
This tool is just an easy way to help your front-end/mobile team how to
communicate with your HTTP API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-apidoc'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec-apidoc

## Usage

Add this to your RSpec setup (eg. `spec/support/autoapi.rb`):

```ruby
RSpec.configure do |config|
  config.add_formatter(RSpec::Apidoc)
  # Optionally add a visual formatter as well...
  # config.add_formatter(:progress)

  config.apidoc_title = 'YOUR.APP API Documentation'
  config.apidoc_description = \
    'A longer intro to add before the examples: authentication, status codes...'

  config.apidoc_host = 'https://api.YOUR.APP'
  # Optionally specify the output file path.
  config.apidoc_output_filename = 'apidoc.html'

  # Customize the authentication header
  config.apidoc_auth_header = lambda do |headers|
    '"Authorization: Bearer $AUTH_TOKEN"' if headers['Authorization']
  end

  # You can add it to any example based on the metadata.
  config.after(:each, type: :request) do |example|
    RSpec::Apidoc.add(self, example)
  end
end
```

## Development

After checking out the repo, run `bundle` to install dependencies.

Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting with this project codebase, issue
tracker, chat rooms and mailing list is expected to follow the [code of
conduct](https://github.com/[USERNAME]/active_record-pgcrypto/blob/master/CODE_OF_CONDUCT.md).
