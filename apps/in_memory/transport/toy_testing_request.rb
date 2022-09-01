# frozen_string_literal: true

module InMemory
  module Transport
    class ToyTestingRequest
      include Import[service: 'contexts.toy_testing.service']

      def call
        puts 'Hello from in_memory toy testing request'
        puts 'Call logic:'
        puts
        sleep 0.5

        service.call

        puts
        sleep 0.5
        puts 'Request done'
      end
    end
  end
end
