# frozen_string_literal: true

require 'parser/current'

module FitnessFunctions
  class ParseFileDependencies
    def call(file_path)
      file = File.read("#{__dir__}/../#{file_path}")

      node = Parser::CurrentRuby.parse(file).loc.node
      find_dependencies(node.to_sexp_array)
    end

    private

    def select_include_nodes(sexp)
      sexp.select { |node| node[0] == :send && node[1].nil? && node[2] == :include }
    end

    def select_di_import_node(import_sexps)
      import_sexps.select { |node| Array(node[3][1])[2] == :Import }
    end

    def get_imported_dependencies(import_sexps)
      import_sexps.empty? ? [] : import_sexps.flat_map { |sexp| sexp[3][3][1..].map { |n| n[2][1] } }
    end

    def find_dependencies(sexp)
      di_imports = []

      loop do
        sexp = sexp.pop

        if sexp[0] == :begin
          di_imports = get_imported_dependencies(
            select_di_import_node(
              select_include_nodes(sexp)
            )
          )
          break
        else
          next
        end
      end

      di_imports
    end
  end

  class CrossContextCallsChecker
    def call(file_path, whitelist: [])
      di_imports = ParseFileDependencies.new.call(file_path)

      puts "Checking: '#{file_path}'"
      puts "Dependencies for file: #{di_imports}"

      di_imports.each do |dependency|
        next if dependency.start_with?(*whitelist)

        raise "Invalid dependency '#{dependency}' for '#{file_path}'"
      end
    end
  end
end

# =========================================

puts '====== Accounting Context ======'
puts

whitelist = %w[
  contexts.accounting.repositories
]

FitnessFunctions::CrossContextCallsChecker.new.call('contexts/accounting/commands/complete_test.rb', whitelist: whitelist)

puts
puts '****'
puts

whitelist = %w[
  persistance.db
]

FitnessFunctions::CrossContextCallsChecker.new.call('contexts/accounting/repositories/account.rb', whitelist: whitelist)
FitnessFunctions::CrossContextCallsChecker.new.call('contexts/accounting/repositories/cat_toy.rb', whitelist: whitelist)

puts
puts '****'
puts

puts '====== Toy testing Context ======'
puts

whitelist = %w[
  contexts.toy_testing.repositories
]

FitnessFunctions::CrossContextCallsChecker.new.call('contexts/toy_testing/commands/assign_toy_to_tester.rb', whitelist: whitelist)
FitnessFunctions::CrossContextCallsChecker.new.call('contexts/toy_testing/commands/send_testing_result.rb',  whitelist: whitelist)

puts
puts '****'
puts

whitelist = %w[
  persistance.db
]

FitnessFunctions::CrossContextCallsChecker.new.call('contexts/toy_testing/repositories/account.rb', whitelist: whitelist)
FitnessFunctions::CrossContextCallsChecker.new.call('contexts/toy_testing/repositories/account.rb', whitelist: whitelist)