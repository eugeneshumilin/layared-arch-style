# frozen_string_literal: true

module ToyTesting
  module Queries
    class GetToysInfo
      include Import[
        account_repo: 'contexts.toy_testing.repositories.account'
        cat_toy_repo: 'contexts.toy_testing.repositories.cat_toy'
      ]

      def call(account_id:)
        get_waiting_toys_info_by_account
      end

      private

      def get_waiting_toys_info_by_account(account_id)
        # call repositories methods and do some stuff
        # Success(result) or Failure(some_error)
      end
    end
  end
end
