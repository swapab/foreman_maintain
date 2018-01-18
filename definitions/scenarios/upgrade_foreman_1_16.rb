module Scenarios::Foreman_1_16
  class Abstract < ForemanMaintain::Scenario
    def self.upgrade_metadata(&block)
      metadata do
        tags :upgrade_to_foreman_1_16
        confine do
          feature(:upstream) && feature(:upstream).current_minor_version == '1.15'
        end
        instance_eval(&block)
      end
    end
  end

  class PreUpgradeCheck < Abstract
    upgrade_metadata do
      description 'Checks before upgrading to Foreman 1.16'
      tags :pre_upgrade_checks
      run_strategy :fail_slow
    end

    def compose
      add_steps(find_checks(:default))
      add_steps(find_checks(:pre_upgrade))
    end
  end

  class PreMigrations < Abstract
    upgrade_metadata do
      description 'Procedures before migrating to Foreman 1.16'
      tags :pre_migrations
    end

    def compose
      add_steps(find_procedures(:pre_migrations))
    end
  end

  class Migrations < Abstract
    upgrade_metadata do
      description 'Migration scripts to Foreman 1.16'
      tags :migrations
    end

    def compose
      add_step(Procedures::Repositories::Setup.new(:version => '1.16'))
      add_step(Procedures::Packages::Update.new(:assumeyes => false))
      add_step(Procedures::Installer::Upgrade.new)
    end
  end

  class PostMigrations < Abstract
    upgrade_metadata do
      description 'Procedures after migrating to Foreman 1.16'
      tags :post_migrations
    end

    def compose
      add_steps(find_procedures(:post_migrations))
    end
  end

  class PostUpgradeChecks < Abstract
    upgrade_metadata do
      description 'Checks after upgrading to Foreman 1.16'
      tags :post_upgrade_checks
      run_strategy :fail_slow
    end

    def compose
      add_steps(find_checks(:default))
      add_steps(find_checks(:post_upgrade))
    end
  end
end

ForemanMaintain::UpgradeRunner.register_version('1.16', :upgrade_to_foreman_1_16)
