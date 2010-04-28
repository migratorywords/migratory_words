class CreatePrCategories < ActiveRecord::Migration
  def self.up
    create_table :pr_categories do |t|
      t.integer :pr_number
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :pr_categories
  end
end
