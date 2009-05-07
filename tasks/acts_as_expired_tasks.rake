# Rake file for acts_as_expired
# 
# To send email alerts to expiring objects, run:
#   rake expires:notify
#

namespace :expires do

  desc 'Notify about objects that are about to expire (by email)'
  task 'notify' => :environment do
    Expire.notifiable.each do |object|
      
      puts %{Sending notification to #{object.notify_email} for object "#{object.expirable}"}

      begin
        mail = ExpiredMailer.deliver_notification(object)
        object.notified_at = Time.now
        object.save
      rescue => error
        puts error
      end
    end    
  end

end