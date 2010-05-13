require 'open-uri'
# require "net/http"
require "cgi"

class HomeController < ApplicationController
  
  def index
    @corpora = Corpus.all
    fav_ngrams = FavoriteNgram.find(:all,:order=>"fav_count",:limit=>6)
    sel_corpus = Corpus.find(:all, :conditions=>{:id=>[6,3,7]})
    @corpora_wise_grams = sel_corpus.map{|c| [c,c.ngrams[0..5]]}
    @corpora_wise_grams.unshift(["favorite",fav_ngrams]) 
  end


  def tool
    @corpora = Corpus.all
    corpus_id = 'bills cr fr hearings presidential reports prnewswire thehill aei brookings cato cfr cgdev civitas fraser nber ncpa rand urban'.split()
    params[:corpus] = 'all' if not params.has_key?(:corpus) or not corpus_id.include?(params[:corpus])
    params[:order] = 'doc' if not params.has_key?(:order) or not 'doc rarity'.split().include?(params[:order])
    params[:word_length_min] = '2' if not params.has_key?(:word_length_min) or not '2 3 4 5 6 7 8 9 10'.split().include?(params[:word_length_min])
    params[:word_length_max] = '8' if not params.has_key?(:word_length_max) or not '2 3 4 5 6 7 8 9 10'.split().include?(params[:word_length_max])
    params[:input_text] = 'test' if params[:input_text] == 'Type a phrase you want to investigate or paste a bulk text.'
    
    begin
      open('http://128.32.33.245:3003/mwords/get_ngrams/?word_length_min='+params[:word_length_min]+'&word_length_max='+params[:word_length_max]+'&text='+URI.encode(params[:input_text])) { |f|
        response = ActiveSupport::JSON.decode(f.read)
        response_true = response['ngrams'].collect{|x| x if x['original']}.compact.sort{|x,y| x['doc_count'] <=> y['doc_count']}
        response_false = response['ngrams'].collect{|x| x if not x['original']}.compact.sort{|x,y| x['doc_count'] <=> y['doc_count']}
        # response_true.concat(response_false)
        @results = {'processedtxt' => response['processedtxt'], 'ngrams' => [response_true, response_false]}
      }
    rescue
      @results = nil
    end
  end
  
  def aboutus
  end
  
  def methodology
  end
  
end
