class DataAddTaxonomies < ActiveRecord::Migration
  def self.up
    Taxonomy.load_from_file
  end

  def self.down
    Taxonomy.delete_all
  end
end
