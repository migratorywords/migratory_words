class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :doc_number
      t.string :corpus

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
