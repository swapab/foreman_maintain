module ForemanMaintain
  module Cli
    module Procedure
      class RunByCommand < Base
        tags_option
        interactive_option

        def execute
          scenario = Scenario::FilteredScenario.new(filter, [:procedure])
          if scenario.steps.empty?
            puts "No scenario matching #{humanized_filter}"
            exit 1
          else
            run_scenario(scenario)
          end
        end

        def filter
          { :tags => tags || [:default] }
        end

        def humanized_filter
          "tags #{filter[:tags].map { |tag| tag_string(tag) }.join}"
        end
      end
    end
  end
end
