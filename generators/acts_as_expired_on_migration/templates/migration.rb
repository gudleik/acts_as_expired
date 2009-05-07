class ActsAsExpiredOnMigration < ActiveRecord::Migration
  
  def self.up
    create_table :expires do |t|
      t.integer   :expirable_id
      t.string    :expirable_type, :limit => 30
      
      t.text      :note
      t.timestamp :at
      t.string    :notify_email
      t.timestamp :notify_at, :default => nil
      t.timestamp :notified_at, :default => nil
      
      t.timestamps      
    end
    
    add_index :expires, [ :expirable_id, :expirable_type ], :unique => true
    add_index :expires, :notify_at
    add_index :expires, :at
  end
  
  def self.down
    drop_table :expires
  end
  
end