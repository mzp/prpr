require "sinatra/base"

module Prpr
  class Server < Sinatra::Base
    enable :logging

    post '/' do
      begin
        Prpr::Runner.new.call params['payload'], event: request.env['HTTP_X_GITHUB_EVENT']
        'ok'
      rescue => e
        logger.error e.message
        "Error: #{e.message}\n#{e.backtrace}"
      end
    end
  end
end
