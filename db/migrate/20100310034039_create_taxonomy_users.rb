class CreateTaxonomyUsers < ActiveRecord::Migration
  def self.up
    create_table :taxonomy_users do |t|
      t.references :taxonomy
      t.references :user
      t.references :language

      t.timestamps
    end
  end

  def self.down
    drop_table :taxonomy_users
  end
end
