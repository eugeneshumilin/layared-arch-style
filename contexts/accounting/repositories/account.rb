# frozen_string_literal: true

module Accounting
  module Repositories
    class Account
      include Import[db: 'persistance.db']

      def complete_test(account_id:, cat_toy_id:, characteristics:)
        # db.transaction
          # complete test for cat toy by account
          # earn 1000 point for account
        # db.commit
      end
    end
  end
end
