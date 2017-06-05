module ForemanMaintain
  module Cli
    module Procedure
      class ListTagsCommand < Base
        # option '--with-procedures', :flag, 'List with tagged procedures'

        def execute
          available_tags(available_procedures).each { |tag| puts tag_string(tag) }
        end
      end
    end
  end
end