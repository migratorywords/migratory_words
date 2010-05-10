class AddColumnSizeInCorpus < ActiveRecord::Migration
  def self.up
    add_column :corpora,:disk_size, :float
  end

  def self.down
  end
end
