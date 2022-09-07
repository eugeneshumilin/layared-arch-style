# frozen_string_literal: true

module ToyTesting
  module Repositories
    class Testing
      include Import[db: "persistence.db"]

      def find(id:)
        testing = testings.first(id: id)
        map_to_entity(testing) if testing
      end

      def queue_size_for_account(account_id:)
        testings.where(account_id: account_id, status: "pending").count
      end

      def pending_testing_for_account(account_id:)
        testings.where(account_id: account_id, status: "pending").order(:created_at).map do |row|
          map_to_entity(row)
        end
      end

      def assign_to_account!(account_id:, cat_toy_id:)
        testing_id = testings.insert(account_id: account_id, cat_toy_id: cat_toy_id)
        find(id: testing_id)
      end

      def account_assigned?(account_id:, cat_toy_id:)
        testings.where(account_id: account_id, cat_toy_id: cat_toy_id, status: "pending").count.positive?
      end

      def add_testing_result!(account_id:, cat_toy_id:, characteristics:)
        testings.where(account_id: account_id, cat_toy_id: cat_toy_id)
                   .update(status: "ready", characteristics: characteristics.to_json)
        map_to_entity(testings.where(account_id: account_id, cat_toy_id: cat_toy_id).first)
      end

      private

      def testings
        @testings ||= db[:testings]
      end

      def map_to_entity(raw_attributes)
        ToyTesting::Entities::Testing.new(prepare(raw_attributes))
      end

      def prepare(row)
        characteristics_json = row.delete(:characteristics)
        characteristics = if characteristics_json
                            JSON.parse(characteristics_json).map { |item| item.transform_keys(&:to_sym) }
                          end
        row.merge(characteristics: characteristics).compact
      end
    end
  end
end
