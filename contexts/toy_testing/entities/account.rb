# frozen_string_literal: true

module ToyTesting
  module Entities
    class Account < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, ToyTesting::Types::Id
      attribute :name, ToyTesting::Types::AccountName
      attribute :email, ToyTesting::Types::AccountEmail
    end
  end
end
