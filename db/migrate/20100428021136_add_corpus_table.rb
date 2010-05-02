class AddCorpusTable < ActiveRecord::Migration
  def self.up
    create_table :corpora do |t|
      t.string  :name
      t.description :description
    end
  end

  def self.down
    drop_table :corpora
  end
end
