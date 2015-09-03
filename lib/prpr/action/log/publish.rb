module Prpr
  module Action
    module Log
      class Publish < Base
        def call
          Publisher::Adapter::Base.broadcast message
        end

        def message
          Prpr::Publisher::Message.new(body: body, from: from, room: room)
        end

        def body
          event.pull_request.title
        end

        def from
          event.sender.login
        end

        def room
          event.class.to_s
        end
      end
    end
  end
end
