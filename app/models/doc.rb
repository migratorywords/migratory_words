class Doc < ActiveRecord::Base
    belongs_to :corpus
    has_and_belongs_to_many :ngrams
end
