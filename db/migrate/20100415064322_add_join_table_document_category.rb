class AddJoinTableDocumentCategory < ActiveRecord::Migration
  def self.up
  create_table :documents_categories do |t|
    t.references :document
    t.references :category
    t.timestamps
  end
  end

  def self.down
    drop_table :document_categories
  end
end
