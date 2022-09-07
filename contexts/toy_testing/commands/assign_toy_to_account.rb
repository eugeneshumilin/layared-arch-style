# frozen_string_literal: true

module ToyTesting
  module Commands
    class AssignToyToAccount
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: "contexts.toy_testing.repositories.account",
        cat_toy_repo: "contexts.toy_testing.repositories.cat_toy",
        testing_repo: "contexts.toy_testing.repositories.testing",
      ]

      MAX_QUEUE_SIZE = 3

      def call(account_id:, cat_toy_id:)
        cat_toy = yield find_toy(cat_toy_id)
        account = yield find_account(account_id)

        assign_toy_to_account!(account, cat_toy)
      end

      private

      def find_toy(toy_id)
        toy = cat_toy_repo.find(id: toy_id)
        return Failure(:cat_toy_not_found) unless toy

        Success(toy)
      end

      def find_account(account_id)
        account = account_repo.find(id: account_id)
        return Failure(:account_not_found) unless account

        Success(account)
      end

      def assign_toy_to_account!(account, cat_toy)
        if testing_repo.queue_size_for_account(account_id: account.id) >= MAX_QUEUE_SIZE
          return Failure(:no_space_in_queue)
        end

        testing = testing.assign_to_account!(account_id: account.id, cat_toy_id: cat_toy.id)
        Success(testing)
      end
    end
  end
end
