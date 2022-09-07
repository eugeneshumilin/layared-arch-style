# frozen_string_literal: true

module ToyTesting
  module Entities
    class CatToy < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, ToyTesting::Types::Id
      attribute :name, ToyTesting::Types::CatToyName
    end
  end
end
