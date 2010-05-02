class CorporaController < ApplicationController
    def index
        @corpora = Corpus.find(:all)
    end
    
    def get_corpora_stat
      @corpora = Corpus.find(:all)
      result = @corpora.inject({}){|a,c| a[c] = c.docs.count}
      render :json => result
    end
end
