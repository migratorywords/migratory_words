class CorporaController < ApplicationController
    def index
        @corpora = Corpus.find(:all)
    end
    
    def get_corpora_stat
      @corpora = Corpus.find(:all)
      result = @corpora.inject({}) do |a,c| 
        a[c.corpus_type] ||= {}
        a[c.corpus_type][c.long_name]= params[:disk_size]=='true' ? c.disk_size : c.doc_count
        a
      end
      render :json => result
    end
end
