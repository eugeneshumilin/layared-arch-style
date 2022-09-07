require "hanami/api"
require "hanami/middleware/body_parser"
require 'hanami/action'

module HTTP
  class App < Hanami::API
    use Hanami::Middleware::BodyParser, :json

    get '/' do
      "Awesome workshop!"
    end

    get '/pending_testings/:account_id', to: Container['http.actions.queries.pending_testings_for_account']

    post '/assign_toy/:cat_toy_id/account/:account_id', to: Container['http.actions.commands.assign_toy_to_account']
    put '/send_testing_result/:account_id/cat_toy/:cat_toy_id', to: Container['http.actions.commands.send_testing_result']
    put '/earn_points/:account_id', to: Container['http.actions.commands.earn_points_for_account']
  end
end
