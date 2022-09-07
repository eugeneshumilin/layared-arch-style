# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:testings) do
      primary_key :id, type: :Integer
      foreign_key :account_id, :accounts, type: Integer
      foreign_key :cat_toy_id, :cat_toys, type: Integer
      String :status, null: false, default: "pending"
      String :characteristics
      Time :created_ad, default: Sequel::CURRENT_TIMESTAMP

      index %i[account_id cat_toy_id], unique: true
    end
  end

  down do
    drop_table(:testings)
  end
end
