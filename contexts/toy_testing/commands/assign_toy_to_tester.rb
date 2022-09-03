# frozen_string_literal: true

module ToyTesting
  module Commands
    class AssignToyToTester
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.toy_testing.repositories.account',
        cat_toy_repo: 'contexts.toy_testing.repositories.cat_toy'
      ]


      def call(account_id:, cat_toy_id:)
        params = yield validate_params({ account_id: account_id, cat_toy_id: cat_toy_id })

        result = yield assign_toy_to_tester(params)

        Success(result: result)
      end

      private

      def validate_params(params)
        # Success(params) or Failure(some_error)
      end

      def assign_toy_to_tester(params)
        # call repositories methods and do some stuff
        # Success(restult) or Failure(some_error)
      end
    end
  end
end
