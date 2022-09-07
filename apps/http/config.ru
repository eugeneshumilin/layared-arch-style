require "bundler/setup"
require_relative '../../config/boot'

run Container['http.app']
