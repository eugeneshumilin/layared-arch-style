# frozen_string_literal: true

module ToyTesting
  module Commands
    class ProcessTestingResult
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: "contexts.toy_testing.repositories.account",
        cat_toy_repo: "contexts.toy_testing.repositories.cat_toy",
        testing_repo: "contexts.toy_testing.repositories.testing",
      ]

      TestingSchemaValidator = Dry::Schema.Params do
        required(:account_id).value(ToyTesting::Types::Id)
        required(:cat_toy_id).value(ToyTesting::Types::Id)
        required(:characteristics).value(ToyTesting::Types::TestingCharacteristics)
      end

      def call(params)
        params = yield validate_testing(params)
        account = yield find_account(params[:account_id])
        toy = yield find_toy(params[:cat_toy_id])

        process_testing_result!(account, toy, params[:characteristics])
      end

      private

      def validate_testing(params)
        TestingSchemaValidator.call(**params).to_monad
      end

      def find_toy(toy_id)
        toy = cat_toy_repo.find(id: toy_id)
        return Failure(:cat_toy_not_found) unless toy
        return Failure(:cat_toy_tested) if cat_toy_repo.tested?(id: toy_id)

        Success(toy)
      end

      def find_account(account_id)
        account = account_repo.find(id: account_id)
        return Failure(:account_not_found) unless account

        Success(account)
      end

      def process_testing_result!(account, toy, characteristics)
        if testing_repo.account_assigned?(account_id: account.id, cat_toy_id: toy.id)
          testing = testing_repo.add_testing_result!(account_id: account.id, cat_toy_id: toy.id,
                                                 characteristics: characteristics)
          Success(testing)
        else
          Failure(:account_not_assigned_to_toy)
        end
      end
    end
  end
end
