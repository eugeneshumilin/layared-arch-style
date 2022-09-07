# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:accounts) do
      primary_key :id, type: :Integer
      String :name, null: false
      String :email, null: false
      TrueClass :blocked, null: false, default: false
      Integer :score, null: false, default: 0
    end
  end

  down do
    drop_table(:accounts)
  end
end
