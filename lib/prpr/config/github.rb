require 'open-uri'

module Prpr
  module Config
    class Github
      attr_reader :repository, :branch

      def initialize(repository, branch: 'master')
        @repository = repository
        @branch = branch
      end

      def read(path)
        URI.parse(url(path)).read
      end

      def url(path)
        "https://github.com/#{repository}/raw/#{branch}/#{path}"
      end
    end
  end
end
