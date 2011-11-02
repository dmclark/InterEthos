class DataAddRoles < ActiveRecord::Migration
  def self.up
    Role.load_from_file
  end

  def self.down
    Role.delete_all
  end
end