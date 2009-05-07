require 'acts_as_expired'

ActiveRecord::Base.send(:include, ActsAsExpired)

RAILS_DEFAULT_LOGGER.info "** acts_as_expired: initialized properly."