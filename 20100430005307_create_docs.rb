class CreateDocs < ActiveRecord::Migration
  def self.up
    create_table :docs do |t|
      t.string :doc_name
      t.datetime :pub_date
      t.integer :corpus_id
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :docs
  end
end
