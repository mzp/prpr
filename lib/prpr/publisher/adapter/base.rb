module Prpr
  module Publisher
    module Adapter
      class Base
        class << self
          def inherited(adapter)
            adapters << adapter.new
          end

          def adapters
            @@adapters ||= []
          end

          def broadcast(message)
            adapters.each do |adapter|
              adapter.publish(message)
            end
          end
        end
      end
    end
  end
end
