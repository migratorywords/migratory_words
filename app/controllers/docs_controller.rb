class DocsController < ApplicationController
    def index
        if params[:corpora_id]
            @corpus = Corpus.find_by_id(params[:corpora_id].to_i)
            @docs = Doc.find(:all, :conditions=>{:corpus_id=>params[:corpora_id].to_i})
        else
            @corpus = {:name=>"entire corpora"} 
            @docs = Doc.find(:all)
        end
    end
end
