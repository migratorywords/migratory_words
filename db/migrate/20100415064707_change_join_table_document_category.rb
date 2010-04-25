class ChangeJoinTableDocumentCategory < ActiveRecord::Migration
  def self.up
    change_table :documents_pr_categories do |t|
        t.remove :pr_cateogry_id
        t.references :pr_category
    end
  end

  def self.down
  end
end
