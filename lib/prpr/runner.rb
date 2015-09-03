module Prpr
  class Runner
    def call(payload, event:)
      e = Prpr::Event::Event.parse(payload, event: event)
      Prpr::Handler::Base.on_event e
    end
  end
end
