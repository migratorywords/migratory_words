class AddNewFieldsToNgrams < ActiveRecord::Migration
  def self.up
    change_table :ngrams do |t|
        t.float   :rarity_score
    end
  end

  def self.down
  end
end
