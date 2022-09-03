# frozen_string_literal: true

require 'dry/system/container'
require "dry/system/loader/autoloading"
require "zeitwerk"

# --- Dry-rb requirements ---
require 'dry-types'
require 'dry/types'
Dry::Types.load_extensions(:monads)

require 'dry/schema'
require 'dry-schema'
Dry::Schema.load_extensions(:monads)

require 'dry-struct'

require 'dry/monads'
require 'dry/monads/do'

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  use :env, inferrer: -> { ENV.fetch('PROJECT_ENV', :development).to_sym }
  use :zeitwerk

  configure do |config|
    # libraries
    config.component_dirs.add 'lib' do |dir|
      dir.memoize = true
    end

    # business logic
    config.component_dirs.add 'contexts' do |dir|
      dir.memoize = true

      dir.namespaces.add 'toy_testing', key: 'contexts.toy_testing'
      dir.namespaces.add 'accounting', key: 'contexts.accounting'
    end

    # simple transport
    config.component_dirs.add 'apps' do |dir|
      dir.memoize = true

      dir.namespaces.add 'in_memory', key: 'in_memory'
    end
  end
end

Import = Container.injector
