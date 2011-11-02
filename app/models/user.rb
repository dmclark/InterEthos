require 'digest/sha1'

class User < ActiveRecord::Base
  acts_as_authentic
  
  belongs_to :validation
  has_many :team_users
    has_many :team, :through => :team_users
  has_many :collection_users
    has_many :collections, :through => :collection_users
  has_many :taxonomy_users
    has_many :taxonomies, :through => :taxonomy_users
  
  has_many :roles_users, :autosave => true
    has_many :roles, :through => :roles_users
      accepts_nested_attributes_for :roles_users, :allow_destroy => true, :reject_if => :all_blank
  # The above "accepts..." is for future functionality where the "User" Edit
  # form will update added information in the "roles_users" table.

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

  def role_symbols  
    roles.map do |role|  
      role.name.underscore.to_sym  
    end  
  end  

  # added to allow email validation / activation of new users
  def activate!
    self.active = true
    save
  end
  
  def deliver_welcome!
    reset_perishable_token!
    UserMailer.welcome.deliver(self)
  end

  protected

end
