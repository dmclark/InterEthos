class Role < ActiveRecord::Base
  
  has_many :role_users, :autosave => true
    has_many :users, :through => :role_users
      accepts_nested_attributes_for :role_users, :allow_destroy => true, :reject_if => :all_blank
  # The above "accepts..." is for future functionality where the "Role" Edit
  # form will update added information in the "role_users" table.
end
