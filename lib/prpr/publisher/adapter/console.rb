module Prpr
  module Publisher
    module Adapter
      class Console < Base
        def publish(message)
          puts "[#{message.room}] <#{message.from.login}> #{message.body}"
        end
      end
    end
  end
end
