require 'digest/sha1'

class User < ActiveRecord::Base
  acts_as_authentic

  validates :first_name, :presence   => true,
                    :length     => { :within => 1..80 }
  validates :last_name, :presence   => true,
                    :length     => { :within => 1..80 }

  validates :username, :presence   => true,
                    :uniqueness => true,
                    :length     => { :within => 3..40 }




  validates :email, :presence   => true,
                    :uniqueness => true,
                    :length     => { :within => 6..100 }

  
  validates :validation_id, :presence   => true

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :username, :password, :password_confirmation, :email, :first_name, :last_name, :validation_id, :roles



  # Authenticates a user by their username and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(username, password)
    return nil if username.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:username => username.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def username=(value)
    write_attribute :username, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected

end
