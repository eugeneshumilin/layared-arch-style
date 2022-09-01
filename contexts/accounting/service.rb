# frozen_string_literal: true

module Accounting
  class Service
    def call
      puts 'Calling accounting context business logic'
      sleep 1
    end
  end
end
