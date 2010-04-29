class CorporaController < ApplicationController
    def index
      @corpora = Corpus.find(:all)
    end
end
