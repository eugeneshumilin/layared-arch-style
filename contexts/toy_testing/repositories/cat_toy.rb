# frozen_string_literal: true

module ToyTesting
  module Repositories
    class CatToy
      include Import[db: "persistence.db"]

      def find(id:)
        cat_toy = cat_toys.first(id: id)
        map_to_entity(cat_toy) if cat_toy
      end

      def tested?(id:)
        db[:testings].where(cat_toy_id: id, status: "ready").count.positive?
      end

      private

      def cat_toys
        @cat_toys ||= db[:cat_toys]
      end

      def map_to_entity(raw_attributes)
        ToyTesting::Entities::CatToy.new(raw_attributes.compact)
      end
    end
  end
end
