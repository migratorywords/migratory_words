class ChangeColNameFromType < ActiveRecord::Migration
  def self.up
    rename_column :ngrams, :type, :ngram_type
  end

  def self.down
  end
end
