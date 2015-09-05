require 'octokit'

module Prpr
  module Repository
    class Github
      class << self
        def default
          Octokit::Client.new(client_options)
        end

        def client_options
          client_options_with_nil_value.reject {|key, value| value.nil? }
        end

        def client_options_with_nil_value
          {
            access_token: access_token,
            api_endpoint: api_endpoint,
            web_endpoint: web_endpoint,
          }
        end

        def web_endpoint
          "https://#{github_host}/" if github_host
        end

        def api_endpoint
          "https://#{github_host}/api/v3" if github_host
        end

        def env
          @env ||= Prpr::Config::Env.default
        end

        def access_token
          env[:github_access_token]
        end

        def github_host
          env[:github_host]
        end
      end
    end
  end
end
