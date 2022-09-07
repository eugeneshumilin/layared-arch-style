# frozen_string_literal: true

module Accounting
  module Repositories
    class Transaction
      include Import[db: 'persistence.db']

      def assign_transaction(account_id:, points:)
        db.transaction
          account = db[:account].find(account_id)
          current_score = account.score
          account.update(score: current_score + points)
        db.commit
      end
    end
  end
end
