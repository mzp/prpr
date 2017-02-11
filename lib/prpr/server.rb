require "sinatra/base"

module Prpr
  class Server < Sinatra::Base
    enable :logging

    post '/' do
      begin
        request.body.rewind
        payload_body = request.body.read
        verify_signature(payload_body)

        Prpr::Runner.new.call params['payload'], event: request.env['HTTP_X_GITHUB_EVENT']
        'ok'
      rescue => e
        logger.error e.message
        "Error: #{e.message}\n#{e.backtrace}"
      end
    end

    private

    def verify_signature(payload_body)
      env = Prpr::Config::Env.default
      return unless env[:secret_token]

      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), env[:secret_token], payload_body)
      return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end
  end
end
