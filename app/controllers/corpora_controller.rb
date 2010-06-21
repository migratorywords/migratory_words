class CorporaController < ApplicationController
    def index
        @corpora = Corpus.find(:all)
    end
    
    def get_corpora_stat
      needed_corpora = (1..19).to_a
      @corpora = Corpus.find(:all, :conditions=>{:id=>needed_corpora})
      result = @corpora.inject({}) do |a,c| 
        a[c.corpus_type] ||= {}
        a[c.corpus_type][c.id]= params[:disk_size]=='true' ? c.disk_size : c.doc_count
        a
      end
      render :json => result
    end

    def show
        @corpora = Corpus.find(:all)
    end

end
