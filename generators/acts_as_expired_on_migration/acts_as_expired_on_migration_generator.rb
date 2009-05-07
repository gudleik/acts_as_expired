class ActsAsExpiredOnMigrationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "acts_as_expired_on_migration"
    end
  end
end
