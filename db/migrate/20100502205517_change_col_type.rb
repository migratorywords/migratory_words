class ChangeColType < ActiveRecord::Migration
  def self.up
    rename_column :new_ngrams, :type, :doc_type
  end

  def self.down
  end
end
