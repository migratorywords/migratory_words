class CreateCorpus < ActiveRecord::Migration
  def self.up
    create_table :corpora do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :corpora
  end
end
