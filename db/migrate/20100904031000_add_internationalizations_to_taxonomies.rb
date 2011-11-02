class AddInternationalizationsToTaxonomies < ActiveRecord::Migration
  def self.up
    add_column :taxonomies, :internationalization_id, :integer
  end

  def self.down
    remove_column :taxonomies, :internationalization_id
  end
end