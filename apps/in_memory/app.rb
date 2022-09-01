# frozen_string_literal: true

require_relative '../../config/boot'

puts 'Loaded container:'
puts "container: #{Container}"
puts "container keys: #{Container.keys}"

puts
puts '*' * 40
puts

Container['in_memory.transport.toy_testing_request'].call
puts
puts '*' * 40
puts
Container['in_memory.transport.accounting_request'].call
