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

        # transform clamp options into procedure params
        def options_to_params
          self.class.recognised_options.inject({}) do |par, option|
            par[option_sym(option)] = send(option.read_method) if metadata_option?(option)
            par
          end
        end

        def self.params_to_options(params)
          params.values.each do |param|
            options = {}
            # clamp doesnt allow required flags
            options[:required] = param.required? unless param.flag?
            options[:multivalued] = param.array?
            option(option_name(param), option_var(param), param.description, options)
          end
        end

        def self.option_name(param)
          ['--' + dashize(param.name.to_s)]
        end

        def self.option_var(param)
          param.flag? ? :flag : param.name.to_s.upcase
        end

        private

        def option_sym(option)
          option.switches.first[2..-1].to_sym
        end

        def metadata_option?(option)
          !option.switches.include?('--help') && !option.switches.include?('--assumeyes')
        end
      end
    end
  end
end
