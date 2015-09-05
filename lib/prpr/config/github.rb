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
        Base64.decode64 resource(path).content.tap { |s| s.force_encoding('utf-8') }
      end

      private

      def resource(path)
        github.content(repository, path: path, ref: branch)
      end

      def github
        @github ||= Prpr::Repository::Github.default
      end
    end
  end
end
