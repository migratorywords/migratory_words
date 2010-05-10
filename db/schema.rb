# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100508205645) do

  create_table "corpora", :force => true do |t|
    t.string  "name"
    t.string  "long_name"
    t.string  "corpus_type"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "doc_count"
    t.text    "description"
    t.float   "disk_size"
  end

  create_table "documents", :force => true do |t|
    t.string   "corpus"
    t.string   "doc_name"
    t.string   "trackback_url"
    t.datetime "published_time"
    t.string   "publisher"
    t.string   "author"
    t.string   "title"
    t.string   "keywords"
    t.string   "categories"
    t.string   "description"
    t.string   "doc_type"
    t.string   "geo_region"
    t.string   "geo_place"
    t.string   "brooking_program"
    t.string   "prnewswire_su"
    t.string   "prnewswire_stock"
    t.string   "louisdb_congress"
    t.string   "louisdb_session"
    t.string   "louisdb_volume"
    t.string   "louisdb_section"
    t.string   "louisdb_chamber"
    t.string   "louisdb_type"
    t.integer  "louisdb_number"
    t.string   "louisdb_version"
    t.string   "louisdb_startpage"
    t.string   "louisdb_endpage"
    t.string   "louisdb_speaker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "corpus_id"
    t.string   "dateline"
  end

  create_table "documents_ngrams", :id => false, :force => true do |t|
    t.integer "ngram_id"
    t.integer "document_id"
  end

  create_table "ngrams", :force => true do |t|
    t.string   "gram_text"
    t.integer  "ngram_type"
    t.string   "hash"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rarity_score"
    t.integer  "corpus_id"
  end

  add_index "ngrams", ["gram_text"], :name => "gram_text", :unique => true

  create_table "pr_categories", :force => true do |t|
    t.integer  "pr_number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_documents", :force => true do |t|
    t.string   "corpus"
    t.string   "doc_name"
    t.string   "trackback_url"
    t.datetime "published_time"
    t.string   "publisher"
    t.string   "author"
    t.string   "title"
    t.string   "keywords"
    t.string   "categories"
    t.string   "description"
    t.string   "doc_type"
    t.string   "geo_region"
    t.string   "geo_place"
    t.string   "brooking_program"
    t.string   "prnewswire_su"
    t.string   "prnewswire_stock"
    t.string   "louisdb_congress"
    t.string   "louisdb_session"
    t.string   "louisdb_volume"
    t.string   "louisdb_section"
    t.string   "louisdb_chamber"
    t.string   "louisdb_type"
    t.integer  "louisdb_number"
    t.string   "louisdb_version"
    t.string   "louisdb_startpage"
    t.string   "louisdb_endpage"
    t.string   "louisdb_speaker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "corpus_id"
    t.string   "dateline"
  end

end
