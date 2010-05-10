class NgramsController < ApplicationController
  def get_ngrams_fake
    open('http://128.32.33.245:3003/mwords/get_ngrams_fake') { |f|
      render :json => ActiveSupport::JSON.decode(f.read)
    }
  end

  def ngram_detail
    @ngram = {'text'=>params[:ngram_text], 'doc_count'=>params[:doc_count]}
    puts @ngram
  end

end
