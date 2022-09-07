# frozen_string_literal: true

module Accounting
  module Repositories
    class Account
      include Import[
        db: 'persistence.db',
        transaction_repo: 'contexts.accounting.repositories.transaction'
      ]

      def find(id:)
        account = accounts.first(id: id)
        map_raw_result_to_entity(account) if account
      end

      def apply_for_assign(account_id:, points:)
        transaction_repo.assign_transaction(account_id: account_id, points: points)
      end

      private

      def accounts
        @accounts ||= db[:accounts]
      end

      def map_raw_result_to_entity(raw_account)
        Accounting::Entities::Account.new(raw_account)
      end
    end
  end
end
