class DataAddTopics < ActiveRecord::Migration
  def self.up
    Topic.load_from_file
  end

  def self.down
    Topic.delete_all
  end
end