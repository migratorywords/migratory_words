require 'cgi'

class NgramsController < ApplicationController
  # def get_ngrams_fake
  #   open('http://128.32.33.245:3003/mwords/get_ngrams_fake') { |f|
  #     render :json => ActiveSupport::JSON.decode(f.read)
  #   }
  # end
  
  # def get_top_ngrams
  #   corpus_id = params[:corpus_id]
  #   # ActiveRecord::Base.include_root_in_json = true
  #   render :json => Ngram.find(:all, :limit => 5).to_json
  #   # render :json => "[{\"ngram\":{\"gram_text\":\"non-institutionalized medicare beneficiaries\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":123,\"id\":61,\"count\":13,\"corpus_id\":null,\"rarity_score\":-336.429}},{\"ngram\":{\"gram_text\":\"requirements for patentability\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":125,\"id\":62,\"count\":14,\"corpus_id\":null,\"rarity_score\":-245.717}},{\"ngram\":{\"gram_text\":\"multivariate behavioral research\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":127,\"id\":63,\"count\":11,\"corpus_id\":null,\"rarity_score\":-248.893}},{\"ngram\":{\"gram_text\":\"increased atmospheric concentrations\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":129,\"id\":64,\"count\":9,\"corpus_id\":null,\"rarity_score\":-284.722}},{\"ngram\":{\"gram_text\":\"physician-level performance measures\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":131,\"id\":65,\"count\":4,\"corpus_id\":null,\"rarity_score\":-290.106}},{\"ngram\":{\"gram_text\":\"correlation between unobserved\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":133,\"id\":66,\"count\":27,\"corpus_id\":null,\"rarity_score\":-250.988}},{\"ngram\":{\"gram_text\":\"men undergoing radical\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":135,\"id\":67,\"count\":7,\"corpus_id\":null,\"rarity_score\":-187.576}},{\"ngram\":{\"gram_text\":\"developing quality indicators\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":137,\"id\":68,\"count\":6,\"corpus_id\":null,\"rarity_score\":-239.707}},{\"ngram\":{\"gram_text\":\"deductibles out-of-pocket limits\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":139,\"id\":69,\"count\":10,\"corpus_id\":null,\"rarity_score\":-266.279}},{\"ngram\":{\"gram_text\":\"months after surgery\",\"created_at\":\"2010-05-01T01:07:52Z\",\"ngram_type\":3,\"updated_at\":null,\"hash\":141,\"id\":70,\"count\":22,\"corpus_id\":null,\"rarity_score\":-179.801}},{\"ngram\":{\"gram_text\":\"thereby disadvantaging the smaller businessman\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":157,\"id\":78,\"count\":2,\"corpus_id\":null,\"rarity_score\":-385.772}},{\"ngram\":{\"gram_text\":\"toward reducing greenhouse gas emissions\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":159,\"id\":79,\"count\":8,\"corpus_id\":null,\"rarity_score\":-352.745}},{\"ngram\":{\"gram_text\":\"training curriculum-based youth entrepreneurship education\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":161,\"id\":80,\"count\":8,\"corpus_id\":null,\"rarity_score\":-485.306}},{\"ngram\":{\"gram_text\":\"brookings institution policy brief policy\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":163,\"id\":81,\"count\":11,\"corpus_id\":null,\"rarity_score\":-359.375}},{\"ngram\":{\"gram_text\":\"discriminatory nature of the policy\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":165,\"id\":82,\"count\":3,\"corpus_id\":null,\"rarity_score\":-310.898}},{\"ngram\":{\"gram_text\":\"percent of charter school students\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":167,\"id\":83,\"count\":11,\"corpus_id\":null,\"rarity_score\":-310.849}},{\"ngram\":{\"gram_text\":\"school operations and performance evidence\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":169,\"id\":84,\"count\":6,\"corpus_id\":null,\"rarity_score\":-362.398}},{\"ngram\":{\"gram_text\":\"association for health services research\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":171,\"id\":85,\"count\":13,\"corpus_id\":null,\"rarity_score\":-338.665}},{\"ngram\":{\"gram_text\":\"drugs levamisole hydrochloride and piperazine\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":173,\"id\":86,\"count\":3,\"corpus_id\":null,\"rarity_score\":-387.0}},{\"ngram\":{\"gram_text\":\"professional development activities for mathematics\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":175,\"id\":87,\"count\":18,\"corpus_id\":null,\"rarity_score\":-421.072}},{\"ngram\":{\"gram_text\":\"five treated districts implemented performance-based\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":177,\"id\":88,\"count\":2,\"corpus_id\":null,\"rarity_score\":-427.603}},{\"ngram\":{\"gram_text\":\"regulating stock externalities under uncertainty\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":179,\"id\":89,\"count\":22,\"corpus_id\":null,\"rarity_score\":-408.373}},{\"ngram\":{\"gram_text\":\"professional development and personnel enhancement\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":181,\"id\":90,\"count\":20,\"corpus_id\":null,\"rarity_score\":-427.985}},{\"ngram\":{\"gram_text\":\"incidence of the healthcare costs\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":183,\"id\":91,\"count\":9,\"corpus_id\":null,\"rarity_score\":-293.257}},{\"ngram\":{\"gram_text\":\"substantially reduce greenhouse gas emissions\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":185,\"id\":92,\"count\":18,\"corpus_id\":null,\"rarity_score\":-386.986}},{\"ngram\":{\"gram_text\":\"autism spectrum disorder and supporting\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":187,\"id\":93,\"count\":7,\"corpus_id\":null,\"rarity_score\":-344.993}},{\"ngram\":{\"gram_text\":\"quarterly financial statements in accordance\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":189,\"id\":94,\"count\":4,\"corpus_id\":null,\"rarity_score\":-365.498}},{\"ngram\":{\"gram_text\":\"new york teachers college press\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":191,\"id\":95,\"count\":25,\"corpus_id\":null,\"rarity_score\":-290.178}},{\"ngram\":{\"gram_text\":\"international and national oil companies\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":193,\"id\":96,\"count\":5,\"corpus_id\":null,\"rarity_score\":-332.867}},{\"ngram\":{\"gram_text\":\"karl director of the national\",\"created_at\":\"2010-05-01T01:10:28Z\",\"ngram_type\":5,\"updated_at\":null,\"hash\":195,\"id\":97,\"count\":6,\"corpus_id\":null,\"rarity_score\":-262.845}}]"
  #   
  # end

  def search
    @corpora = Corpus.all
    corpus_id = 'bills cr fr hearings presidential reports prnewswire thehill aei brookings cato cfr cgdev civitas fraser nber ncpa rand urban'.split()
    params[:corpus] = 'all' if not params.has_key?(:corpus) or not corpus_id.include?(params[:corpus])
    params[:order] = 'doc' if not params.has_key?(:order) or not 'doc rarity'.split().include?(params[:order])
    params[:word_length_min] = '2' if not params.has_key?(:word_length_min) or not '2 3 4 5 6 7 8 9 10'.split().include?(params[:word_length_min])
    params[:word_length_max] = '8' if not params.has_key?(:word_length_max) or not '2 3 4 5 6 7 8 9 10'.split().include?(params[:word_length_max])
    params[:text] = 'president of south korea' if params[:text] == 'Type a phrase you want to investigate or paste a bulk text.'
    
    begin
      open('http://128.32.33.245:3003/mwords/get_ngrams/?word_length_min='+params[:word_length_min]+'&word_length_max='+params[:word_length_max]+'&text='+URI.encode(params[:text])) { |f|
        response = ActiveSupport::JSON.decode(f.read)
        response_true = response['ngrams'].collect{|x| x if x['original']}.compact.sort{|x,y| x['doc_count'] <=> y['doc_count']}
        response_false = response['ngrams'].collect{|x| x if not x['original']}.compact.sort{|x,y| x['doc_count'] <=> y['doc_count']}
        # response_true.concat(response_false)
        @results = {'processedtxt' => response['processedtxt'], 'ngrams' => [response_true, response_false]}
        @default_text = CGI::escape(response['processedtxt'])
      }
    rescue
      @results = nil
    end
  end
  
  def top
    @corpora = Corpus.all
  end
  
  def top_corpus
    @corpora = Corpus.all
    @current_corpus = Corpus.find_by_name(params[:id])
    ngrams = Ngram.find(:all, :select => "text,length,score,doc_count", :limit => 5).collect{|x| {"text" => x.text, "length" => x.length, "score" => x.score, "original" => false, "doc_count" => x.doc_count}}
    @results = {"ngrams" => ngrams}
  end
  
  def detail
    @ngram = {'text'=>params[:text], 'doc_count'=>params[:doc_count]}
    puts @ngram
  end

end
