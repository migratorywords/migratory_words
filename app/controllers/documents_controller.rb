class DocumentsController < ApplicationController
    def index
        if params[:corpora_id]
            @corpus = Corpus.find_by_id(params[:corpora_id].to_i)
            @documents = Document.find(:all, :conditions=>{:corpus_id=>params[:corpora_id].to_i})
        else
            @corpus = {:name=>"entire corpora"} 
            @documents = Document.find(:all)
        end
    end

end
