class RolesUser < ActiveRecord::Base
  using_access_control

  belongs_to :role
  belongs_to :user
  validates_presence_of :user, :role
  validates_associated :user, :role
end
