class CreateNgrams < ActiveRecord::Migration
  def self.up
    create_table :ngrams do |t|
      t.string :gram_text
      t.integer :type
      t.string :hash
      t.integer :count

      t.timestamps
    end
    create_table :ngrams_documents do |t|
      t.references :ngram
      t.references :document
    end
  end

  def self.down
    drop_table :ngrams
  end
end
