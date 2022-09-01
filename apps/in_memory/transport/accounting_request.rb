# frozen_string_literal: true

module InMemory
  module Transport
    class AccountingRequest
      include Import[service: 'contexts.accounting.service']

      def call
        puts 'Hello from in_memory accounting request'
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
