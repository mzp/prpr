module Prpr
  class Runner
    def initialize
      bundle
    end

    def call(payload, event:)
      e = Prpr::Event::Event.parse(payload, event: event)
      Prpr::Handler::Base.on_event e
    end

    def bundle
      ::Bundler.require
    rescue ::Bundler::GemfileNotFound
    end
  end
end
