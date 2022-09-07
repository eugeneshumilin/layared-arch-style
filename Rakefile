# frozen_string_literal: true

require File.expand_path("config/environment", __dir__)
require File.expand_path("config/boot", __dir__)

require "rake"

Rake.add_rakelib "lib/tasks"

task :environment do
  ENV["APP_ENV"] ||= "development"
end
