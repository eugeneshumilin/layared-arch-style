# frozen_string_literal: true

module ToyTesting
  module Commands
    class SendTestingResult
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.toy_testing.repositories.account',
        cat_toy_repo: 'contexts.toy_testing.repositories.cat_toy'
      ]


      def call(account_id:, cat_toy_id:)
        params = yield validate_params({ account_id: account_id, cat_toy_id: cat_toy_id })

        result = yield send_testing_result(params)

        Success(result: result)
      end

      private

      def validate_params(params)
        # Success(params) or Failure(some_error)
      end

      def send_testing_result(params)
        # call repositories methods and do some stuff
        # Success(result) or Failure(some_error)
      end
    end
  end
end
