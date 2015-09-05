module Prpr
  module Publisher
    class Message
      def initialize(orininal={})
        @original = orininal
      end

      def body
        @original[:body]
      end

      def from
        OpenStruct.new @original[:from]
      end

      def room
        @original[:room]
      end
    end
  end
end
