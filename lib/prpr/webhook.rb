module Prpr
  class Webhook
    attr_reader :repo, :url

    MSG = 'USAGE: bin/webhook <repo> <url>'.freeze

    def initialize(repo, url)
      @repo = repo
      @url = url
    end

    def create_or_update
      fail MSG unless valid?

      config = { url: url, secret: secret }
      options = { events: Event::Event.events.keys }
      if hook
        client.edit_hook(repo, hook.id, 'web', config, options)
      else
        client.create_hook(repo, 'web', config, options)
      end
    end

    def url_for(hook)
      host = Prpr::Repository::Github.github_host || 'github.com'
      "https://#{host}/#{repo}/settings/hooks/#{hook.id}"
    end

    private

    def valid?
      repo.to_s.split('/').size == 2 && url.to_s =~ URI.regexp
    end

    def hook
      @hook ||= client.hooks(repo).find { |hook| hook.config.url == url }
    end

    def client
      @client ||= Prpr::Repository::Github.default
    end

    def env
      @env ||= Prpr::Config::Env.default
    end

    def secret
      env[:secret_token]
    end
  end
end
