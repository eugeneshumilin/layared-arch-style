# frozen_string_literal: true

module Accounting
  module Types
    include Dry.Types()

    # Types for characteristics
    CharacteristicType = Types::String.enum('happines', 'playful', 'safeties', 'brightness')
    Value = String.constrained(
      format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    )
    Comment = String.optional
    WillReccomend = Bool.default(false)
  end
end
