require 'foreman_maintain/cli/procedure/run_command'
require 'foreman_maintain/cli/procedure/list_tags_command'
require 'foreman_maintain/cli/procedure/run_by_command'

module ForemanMaintain
  module Cli
    class ProcedureCommand < Base
      subcommand 'run', 'Run maintain procedures manually', Procedure::RunCommand
      subcommand 'run-by', 'Run maintain procedures manually', Procedure::RunByCommand
      subcommand 'list-tags', 'List tags used in procedures', Procedure::ListTagsCommand
    end
  end
end
