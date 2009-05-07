# This class holds information about the expiration, 
# such as time when object expires and notification options.
#
#   create_table :expires do |t|
#     t.integer   :expirable_id
#     t.string    :expirable_type, :limit => 30
#     
#     t.text      :note
#     t.timestamp :at
#     t.string    :notify_email
#     t.timestamp :notify_at, :default => nil
#     t.timestamp :notified_at, :default => nil
#     
#     t.timestamps      
#   end
#
# There are also some named scopes you can use to fetch all expired/expiring objects:
# Some examples:
#   Expire.expired                  # => all expired objects
#   Expire.notifiable               # => all objects that are about to expire with notification options set.
#   Expire.within                   # => all objects that expires within 2 weeks from now
#   Expire.within 3.months.from_now # => returns all objects that expires within 3 months from now
#
class Expire < ActiveRecord::Base

  belongs_to :expirable, :polymorphic => true
  
  validate :validate_dates
  
  # All expired objects
  named_scope :expired, :conditions => [ 'NOW() >= at' ], :order => 'expires.at'
  
  # All notifiable objects that are about to expire
  named_scope :notifiable, :conditions => [ "NOW() >= notify_at AND (NOW() <= notified_at OR notified_at IS NULL) AND notify_email != ''"], :order => 'expires.at'
  
  # All objects that are about to expire
  named_scope :within, lambda { |*args| { :conditions => [ "at <= ?", (args.first || 2.weeks.from_now )]} }

  #
  # Returns true if object has expired
  #
  def expired?
    return false if at.nil?
    return at.past?
  end
  
  #
  # Notification is only enabled if notify_email and notify_at is set
  #
  def notification_enabled?
    not notify_email.blank? and not notify_at.nil?
  end
  
  private
  
  # 
  # Make sure expiry date is in future and notification date is before expiry date
  #
  def validate_dates
    errors.add(:at, :expire_date_is_in_past) if self.at < Time.now
    errors.add(:notify_at, :notify_date_is_before_expiry_date) if self.notify_at > self.at
  end
  
end