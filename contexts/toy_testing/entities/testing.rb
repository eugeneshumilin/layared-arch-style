# frozen_string_literal: true

module ToyTesting
  module Entities
    class Testing < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, ToyTesting::Types::Id
      attribute :account_id, ToyTesting::Types::Id
      attribute :cat_toy_id, ToyTesting::Types::Id
      attribute :status, ToyTesting::Types::TestingStatus
      attribute? :characteristics, ToyTesting::Types::TestingCharacteristics
    end
  end
end
