module Prpr
  module Action
    class Base
      attr_reader :event

      def initialize(event)
        @event = event
      end
    end
  end
end

