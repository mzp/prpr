module Prpr
  module Action
    class Base
      attr_reader :event

      def initialize(event)
        @event = event
      end

      def env
        Config::Env.default
      end
    end
  end
end

