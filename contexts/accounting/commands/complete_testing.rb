# frozen_string_literal: true

module Accounting
  module Commands
    class CompleteTesting
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.accounting.repositories.account',
        testing_repo: "contexts.accounting.repositories.testing",
      ]

      DEFAULT_POINTS = 1_000

      def call(account_id)
        account = yield find_account(account_id)
        completed_testings_count = yield collect_completed_testings(account)
        account = yield apply_for_assign(account, completed_testings_count)
        
        Success(account: account, completed_testings: completed_testings_count)
      end

      private

      def find_account(account_id)
        account = account_repo.find(id: account_id)
        return Failure(:account_not_found) unless account
        return Failure(:account_is_blocked) if account.blocked?

        Success(account)
      end

      def collect_completed_testings(account)
        testings = testing_repo.completed_by_account(account_id: account.id)
        return Failure(:testings_not_found) unless testings
        
        Success(testings)
      end

      def apply_for_assign(account, testings_count)
        points = testings_count * DEFAULT_POINTS
        Success(account_repo.apply_for_assign(id: account.id, points: points))
      end
    end
  end
end
