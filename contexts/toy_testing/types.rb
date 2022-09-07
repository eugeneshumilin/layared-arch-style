# frozen_string_literal: true

module ToyTesting
  module Types
    include Dry.Types()

    Id = Integer.constrained(gt: 0)

    AccountName = String.constrained(min_size: 2, max_size: 255)
    AccountEmail = String.constrained(format: URI::MailTo::EMAIL_REGEXP)

    CatToyName = String.constrained(min_size: 2, max_size: 255)
    
    TestingStatus = String.default("pending").enum("pending", "ready")

    TestingCharacteristicType = String.enum("happiness", "playful", "safeties", "brightness")
    TestingCharacteristicValue = String.constrained(format: /\A[a-z0-9]{8}\z/i)
    TestingCharacteristic = Types::Hash.schema(
      characteristic_type: TestingCharacteristicType,
      value: TestingCharacteristicValue,
      comment?: String,
      will_recommend: Bool.default(true)
    )
    TestingCharacteristics = Array.of(TestingCharacteristic)
  end
end
