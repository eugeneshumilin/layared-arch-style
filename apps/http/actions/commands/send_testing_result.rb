# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class SendTestingResult < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          command: 'contexts.toy_testing.commands.process_testing_result'
        ]

        def handle(req, res)
          result = command.call(
            cat_toy_id: req.params[:cat_toy_id],
            account_id: req.params[:account_id],
            characteristics: req.params[:characteristics]
          )

          case result
          in Success
            res.status = 200
            res.body = result.value!.to_json
          in Failure[_, error_message]
            halt 422, error_message.to_json
          end
        end
      end
    end
  end
end
