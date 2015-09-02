require 'prpr/event/pull_request'
require 'json'

module Prpr
  module Event
    class UnknownEvent < StandardError
    end

    class Event
      class << self
        def parse(payload, event:)
          case event
          when 'pull_request'
            PullRequest.new(JSON.parse(payload))
          else
            fail UnknownEvent
          end
        end
      end
    end
  end
end
