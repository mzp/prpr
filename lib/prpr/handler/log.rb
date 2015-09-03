module Prpr
  module Handler
    class Log < Base
      handle AnyEvent do
        Prpr::Action::Log::Publish.new(event).call
      end
    end
  end
end
