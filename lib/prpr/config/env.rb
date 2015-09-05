module Prpr
  module Config
    class Env
      class << self
        def default
          @default ||= new
        end
      end

      def [](name)
        ENV[name.to_s.upcase]
      end

      def format(name, params = {})
        self[name].to_s % symbolize_keys(params.to_h)
      end

      private

      def symbolize_keys(hash)
        ret = {}

        hash.keys.each do|key|
          ret[key.to_sym] = hash[key]
        end

        ret
      end
    end
  end
end
