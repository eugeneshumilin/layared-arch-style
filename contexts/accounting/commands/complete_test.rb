# frozen_string_literal: true

module Accounting
  module Commands
    class CompleteTest
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.accounting.repositories.account'
      ]

      CharacteristicsValidator = Dry::Schema.Params do
        required(:characteristics).array(:hash, min_size?: 1) do
          required(:caracteristic_type).value(Accounting::Types::CharacteristicType)
          required(:value).value(Accounting::Types::Value)
          required(:comment).value(Accounting::Types::Comment)
          required(:will_recommend).value(Accounting::Types::WillReccomend)
        end
        
      end

      def call(account_id:, cat_toy_id:, characteristics:)
        characteristics = yield validate_characteristics(characteristics)

        result = yield account_repo.complete_test(
          account_id: account_id, cat_toy_id: cat_toy_id, characteristics: characteristics
        )

        Success(result: result)
      end

      private

      def validate_characteristics(characteristics)
        CharacteristicsValidator.call(characteristics: characteristics).to_monad
          .fmap { |result| result[:characteristics] }
          .or   do |result| 
            Failure(
              [:invalid_characteristics, { error_message: result.to_h, original_characteristics: characteristics }]
            ) 
          end
      end
    end
  end
end
