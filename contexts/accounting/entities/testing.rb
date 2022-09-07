# frozen_string_literal: true

module Accounting
  module Entities
    class Testing < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Accounting::Types::Id
      attribute :account_id, Accounting::Types::Id
      attribute :cat_toy_id, Accounting::Types::Id
    end
  end
end
