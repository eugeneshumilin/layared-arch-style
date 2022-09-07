# frozen_string_literal: true

module Accounting
  module Entities
    class Account < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Accounting::Types::Id
      attribute :blocked, Accounting::Types::Bool
      attribute :score, Accounting::Types::Score

      def blocked?
        blocked
      end
    end
  end
end
