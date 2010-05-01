class AddCorpusFieldToNgrams < ActiveRecord::Migration
  def self.up
    add_column :ngrams, :corpus_id, :integer
  end

  def self.down
  end
end
