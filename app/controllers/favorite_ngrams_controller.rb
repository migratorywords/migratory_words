class FavoriteNgramsController < ApplicationController
  def index
    @fav_ngrams = FavoriteNgram.all 
  end
  
  def create
    ngram_text = params[:text]
    ngram_score = params[:score]
    ngram_length = params[:length]
    doc_count = params[:doc_count]
    ngram_from_db = FavoriteNgram.find_by_text(ngram_text)

    unless ngram_from_db
      begin
        open('http://128.32.33.245:3003/mwords/get_docs/?ngram='+URI.encode(ngram_text)) { |f|
          all_doc_ids = ActiveSupport::JSON.decode(f.read)
          puts all_doc_ids
          all_doc_ids.map!{|x| x.to_i}
          ng = FavoriteNgram.new(:text=>ngram_text,:doc_count=>doc_count,:rarity_score=>ngram_score,:length=>ngram_length,:fav_count=>1)
          ng.document_ids= all_doc_ids
          ng.save
          render :json => {:error=>false, :ngram=>ng}
        }
      rescue
         render :json => {:error=>true}
      end
    else
      fvc = ngram_from_db.fav_count
      ngram_from_db.update_attribute(:fav_count=>(fvc + 1))
      render :json => {:message => 'fav count updated'}
    end
  end
end
