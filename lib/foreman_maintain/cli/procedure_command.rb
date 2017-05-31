require 'foreman_maintain/cli/procedure/run_command'

module ForemanMaintain
  module Cli
    class ProcedureCommand < Base
      subcommand 'run', 'Run maintain procedures manually', Procedure::RunCommand
    end
  end
end