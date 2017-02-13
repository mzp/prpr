require 'prpr/event/pull_request'
require 'json'

module Prpr
  module Event
    class UnknownEvent < StandardError
    end

    class Event
      class << self
        def events
          {
            commit_comment: CommitComment,
            issue_comment: IssueComment,
            pull_request: PullRequest,
            pull_request_review: PullRequestReview,
            pull_request_review_comment: PullRequestReviewComment,
            push: Push
          }
        end

        def parse(payload, event:)
          klass = events[event.to_sym]
          fail UnknownEvent, event unless klass

          klass.new(JSON.parse(payload))
        end
      end
    end
  end
end
