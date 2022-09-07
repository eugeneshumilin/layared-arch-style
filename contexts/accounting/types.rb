# frozen_string_literal: true

module Accounting
  module Types
    include Dry.Types()

    Id = Params::Integer.constrained(gt: 0)
    Score = Params::Integer.constrained(gt: -1)
  end
end
