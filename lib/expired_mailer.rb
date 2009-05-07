# Class for sending alerts when objects are about to expire.

class ExpiredMailer < ActionMailer::Base
  
  #
  # Send notification about an expiring object
  #
  def notification(object)
    raise ArgumentError, "notify_email not set!" if object.notify_email.blank?
    
    recipients  object.notify_email
    subject     I18n.t('expired_mailer.notification.subject', :expirable => object.expirable)
    from        Settings.mail.headers.from
    headers     'reply-to' => Settings.mail.headers.devnull
    body        :object => object
  end

end
