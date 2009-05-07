# ActsAsExpired
#
# This module is included in ActiveRecord::Base, so you can add this feature
# to your model using +acts_as_expirable+.
#
# Making an ActiveRecord class "acts as expired" means you can add expiry
# information to it.

module ActsAsExpired
  
  #
  # Called when plugin is included
  #
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def acts_as_expired
      include ActsAsExpired::InstanceMethods
      has_one :expire, :as => :expirable
    end
  end
  
  module InstanceMethods
    
    # Returns true if the object has expired.
    def expired?
      return false if expire.nil?
      expire.expired?
    end
    
    #
    # Creates or updates the Expire object for the class.
    # 
    # The options hash is passed directly to the Expire object, so you can pass 
    # any valid attribute found in the Expire class.
    #
    # Some values have default settings:
    # * :at             Time when object should expire. Default is 1.year.from_now
    # * :notify_at      Time when notification should be sent. Default is 30.days before :at
    #                   You can pass both a Time object or a Fixnum, like 30.days
    # * :notify_email   Email address that should receive expiry email. Default is nil.
    #
    # Returns the expire object.
    # An error is raised if the record is invalid.
    #
    def expires!(options = {})
      options = {
        :at           => 1.year.from_now,
        :notify_at    => 30.days,
        :notify_email => nil
      }.update(options)
      
      # set notify_at 
      if options[:notify_at].is_a?(Fixnum)
        options[:notify_at] = options[:notify_at].until(options[:at])
      end
      
      # Create or update existing object      
      if self.expire.nil?
        self.expire = Expire.create!(options)
      else
        self.expire.update_attributes!(options)
      end
      
      self.expire
    end
  end
  
end