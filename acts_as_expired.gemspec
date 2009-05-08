Gem::Specification.new do |s|
  s.name        = %q{acts_as_expired}
  s.version     = "0.0.2"
  s.date        = %q{2009-05-07}
  s.authors     = [ "Gudleik Rasch" ]
  s.email       = %q{gudleik@rastamatra.org}
  s.homepage    = "http://github.com/gudleik/acts_as_expired/tree"
  s.has_rdoc    = false
  s.summary     = %q{Rails plugin that allows expiring of ActiveRecord models}
  s.description = %q{Rails plugin that allows expiring of ActiveRecord models}
  s.files = [ 
    "README.rdoc", 
    "MIT-LICENSE",
    "init.rb",
    "rails/init.rb",
    "tasks/acts_as_expired_tasks.rake",

    "lib/acts_as_expired.rb",
    "lib/expire.rb",
    "lib/expired_mailer.rb",

    "generators/acts_as_expired_mailer/acts_as_expired_mailer_generator.rb",
    "generators/acts_as_expired_mailer/templates/notification.text.html.erb",
    "generators/acts_as_expired_mailer/templates/notification.text.plain.erb",
    "generators/acts_as_expired_on_migration/acts_as_expired_on_migration_generator.rb",
    "generators/acts_as_expired_on_migration/templates/migration.rb"
  ]     

end
