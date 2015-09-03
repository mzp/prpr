module Prpr
  module Publisher
    module Adapter
      class Console < Base
        def publish(message)
          puts "[#{message.room}] <#{message.from}> #{message.body}"
        end
      end
    end
  end
end
