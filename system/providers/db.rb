# frozen_string_literal: true

Container.register_provider(:db) do
  prepare do
    require 'sequel'

    Sequel.extension :migration
  end

  start do
    db = Sequel.sqlite('sqlite://dry_course.db')

    register('persistence.db', db)
  end
end
