class Corpus < ActiveRecord::Base
    set_table_name "corpora"
    has_many :documents
    has_many :ngrams
end
