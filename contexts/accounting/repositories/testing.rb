# frozen_string_literal: true

module Accounting
  module Repositories
    class Testing
      include Import[db: "persistence.db"]

      def completed_by_account(account_id:)
        db[:testings].where(account_id: account_id, status: "ready").map do |row|
          map_to_entity(row)
        end
      end

      private

      def map_to_entity(row)
        Accounting::Entities::Testing.new(row)
      end
    end
  end
end
