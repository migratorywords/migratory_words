class AddMetadataToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
        t.string :author 
        t.datetime :published_time 
        t.string :geo_region 
        t.string :geo_place 
        t.string :publisher 
        t.text :description 
    end
  end

  def self.down
  end
end
