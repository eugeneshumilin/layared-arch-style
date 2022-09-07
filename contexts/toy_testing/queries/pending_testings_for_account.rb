# frozen_string_literal: true

module ToyTesting
  module Queries
    class PendingTestingsForAccount
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: "contexts.toy_testing.repositories.account",
        testing_repo: "contexts.toy_testing.repositories.testing",
      ]

      def call(account_id:)
        account = yield find_account(account_id)

        fetch_pending_testings(account)
      end

      private

      def find_account(account_id)
        account = account_repo.find(id: account_id)
        return Failure(:account_not_found) unless account

        Success(account)
      end

      def fetch_pending_testings(account)
        testings = testing_repo.pending_testings_for_account(account_id: account.id)

        Success(testings)
      end
    end
  end
end
