class RemoveIdFromJoinTable < ActiveRecord::Migration
  def self.up
  remove_column :documents_pr_categories, :id
  end

  def self.down
  end
end
