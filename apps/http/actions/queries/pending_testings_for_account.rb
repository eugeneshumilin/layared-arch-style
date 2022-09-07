# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Queries
      class PendingTestingsForAccount < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          query: 'contexts.toy_testing.queries.pending_testings_for_account'
        ]

        def handle(req, res)
          result = query.call(
            account_id: req.params[:account_id]
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
