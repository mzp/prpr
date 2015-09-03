module Prpr
  module Handler
    class Base
      class Entry < Struct.new(:klass, :event, :queries, :handler)
      end

      AnyEvent = Object

      class << self
        def handle(event, queries = {}, &handler)
          entries << Entry.new(self, event, queries, handler)
        end

        def entries
          @@entries ||= []
        end

        def on_event(event)
          entries
            .select { |entry| match?(entry, event) }
            .each { |entry| invoke(entry, event) }
        end

        private

        def match?(entry, event)
          entry.event === event &&
            entry.queries.all? { |query| query_match?(query, event) }
        end

        def query_match?(query, event)
          key, value = *query
          value === event.send(key)
        end

        def invoke(entry, event)
          obj = entry.klass.new(event)
          obj.instance_eval(&entry.handler)
        end
      end

      attr_reader :event
      def initialize(event)
        @event = event
      end
    end
  end
end
