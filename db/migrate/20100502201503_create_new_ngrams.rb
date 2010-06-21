class CreateNewNgrams < ActiveRecord::Migration
  def self.up
    create_table :new_ngrams do |t|
        t.string  :corpus
        t.string  :doc_id
        t.string  :trackback_url
        t.datetime  :published_time
        t.string  :publisher
        t.string  :author
        t.string  :title
        t.string  :keywords
        t.string  :categories
        t.string  :description
        t.string  :type
        t.string  :geo_region
        t.string  :geo_place
        t.string  :brooking_program
        t.string  :prnewswire_su
        t.string  :prnewswire_stock
        t.string  :louisdb_congress
        t.string  :louisdb_session
        t.string  :louisdb_volume
        t.string  :louisdb_section
        t.string  :louisdb_chamber
        t.string  :louisdb_type
        t.integer :louisdb_number
        t.string  :louisdb_version
        t.string  :louisdb_startpage
        t.string  :louisdb_endpage
        t.string  :louisdb_speaker
        t.timestamps
    end
  end

  def self.down
    drop_table :new_ngrams
  end
end
