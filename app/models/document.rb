class Document < ActiveRecord::Base
    has_and_belongs_to_many :pr_categories
    validates_uniqueness_of :doc_number
end
