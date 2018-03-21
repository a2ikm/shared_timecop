$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

ENV["RAILS_ENV"] ||= "test"
require "rails"
require "bundler/setup"
Bundler.require
require_relative "fake_app/rails_app"

require "shared_timecop"

Dir[File.join(__dir__, "support", "**", "*.rb")].each do |path|
  require path
end

require "minitest/autorun"
