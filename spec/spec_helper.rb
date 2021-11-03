# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'

SimpleCov.start do
  add_group 'Lib', 'lib'
  add_group 'Tests', 'spec'
end
SimpleCov.minimum_coverage 90

require 'rack/lobster'
require 'rails'
require 'action_controller/railtie'

# Test controller docstring
class TestController < ActionController::Base
  # Index docstring
  #
  # @return [String]
  def index
    render json: { test: :ok }, status: 418
  end
end

class Dummy < Rails::Application
  secrets.secret_key_base = '_'
  config.hosts << 'www.example.com' if config.respond_to?(:hosts)

  config.logger = Logger.new($stdout)
  Rails.logger  = config.logger

  routes.draw do
    post '/test' => 'test#index'
    mount Rack::Lobster.new, at: '/lobster'
  end
end

require 'rspec/rails'
require 'rspec/apidoc'

# Apidoc config...
RSpec.configure do |config|
  config.add_formatter(RSpec::Apidoc)
  config.add_formatter(:doc)

  config.apidoc_title = 'YOUR.APP API Documentation'
  config.apidoc_description = 'YOUR.APP long description'

  config.apidoc_host = 'https://api.YOUR.APP'
  config.apidoc_output_filename = Tempfile.new

  config.after(:each, apidoc: true) do |example|
    RSpec::Apidoc.add(self, example)
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.filter_run_when_matching :focus
  # Keep this to collect the specs and test the compiled doc HTML
  config.order = :defined

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
