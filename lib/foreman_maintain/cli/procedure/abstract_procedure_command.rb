module ForemanMaintain
  module Cli
    module Procedure
      class AbstractProcedureCommand < Base
        def execute
          label = underscorize(invocation_path.split.last)
          params = options_to_params
          procedure = procedure(label.to_sym).new(params)
          scenario = ForemanMaintain::Scenario.new
          scenario.add_step(procedure)
          run_scenario(scenario)
        end

        # transform clamp optoins into procedure params
        def options_to_params
          self.class.recognised_options.inject({}) do |par, option|
            if !option.switches.include?('--help') && !option.switches.include?('--assumeyes')
              param = option.switches.first[2..-1].to_sym
              par[param] = send(option.read_method)
            end
            par
          end
        end

        def self.params_to_options(params)
          params.values.each do |param|
            options = {}
            options[:required] = param.required? unless param.flag? # clamp doesnt allow required flags
            options[:multivalued] = param.array?
            option_var = param.flag? ? :flag : param.name.to_s.upcase
            option('--' + dashize(param.name.to_s), option_var, param.description, options)
          end
        end
      end
    end
  end
end
