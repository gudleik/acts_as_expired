class ActsAsExpiredMailerGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.directory "app/views/expired_mailer"
      m.file 'notification.text.html.erb', 'app/views/expired_mailer/notification.text.html.erb'
      m.file 'notification.text.plain.erb', 'app/views/expired_mailer/notification.text.plain.erb'
    end
  end
  
end