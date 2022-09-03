# frozen_string_literal: true

Container.register_provider(:db) do
  prepare do
    require 'sequel'

    db = Sequel.connect('sqlite://dry_course.db')

    register('persistance.db', db)
  end
end
