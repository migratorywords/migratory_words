require 'open-uri'
# require "net/http"
require "cgi"

class HomeController < ApplicationController
  
  include ProxySearcher
  
  def index
    @corpus_id = 'bills cr fr hearings presidential reports prnewswire thehill aei brookings cato cfr cgdev civitas fraser nber ncpa rand urban'.split()
    @corpus_name = 'Bills,Congressional Records,Federal Register,Congressional Hearings,Presidential Records,Congressional Reports,PR Newswire,The Hill,AEI,Brookings,Cato,Center for Foreign Relations,Center for Global Development,Civitas,Fraser,National Bureau of Economic Research,National Center for Policy Analysis,Rand Corp.,Urban Institute'.split(',')
    @corpus_hash = {}
    @corpus_id.size.times { |i| @corpus_hash[ @corpus_id[i] ] = @corpus_name[i] }
  end

  def new_index
    @corpora= Corpus.all
    #@corpus_name = Corpus.all.map{|c| c.long_name}
    #@corpus_hash = Corpus.all.inject({}){|hash,corpus| hash[corpus.name]||=corpus.long_name; hash}
  end


  def tool
    @corpora = Corpus.all
    corpus_id = 'bills cr fr hearings presidential reports prnewswire thehill aei brookings cato cfr cgdev civitas fraser nber ncpa rand urban'.split()
    params[:corpus] = 'all' if not params.has_key?(:corpus) or not corpus_id.include?(params[:corpus])
    params[:order] = 'doc' if not params.has_key?(:order) or not 'doc rarity'.split().include?(params[:order])
    params[:word_length_min] = '2' if not params.has_key?(:word_length_min) or not '2 3 4 5 6 7 8'.split().include?(params[:word_length_min])
    params[:word_length_max] = '8' if not params.has_key?(:word_length_max) or not '2 3 4 5 6 7 8'.split().include?(params[:word_length_max])
    params[:input_text] = 'test' if params[:input_text] == 'Type a phrase you want to investigate or paste a bulk text.'
    
    puts '*************************abc****************************'
    open('http://128.32.33.245:3003/mwords/get_data/?text='+URI.encode(params[:input_text])) { |f|
      parsed_json = ActiveSupport::JSON.decode(f.read)
      # parsed_json = ActiveSupport::JSON.decode('[{"text":"environmental protection department","docs":["fr-2007-jn-08-fr08jn07-53","82368912","fr-2005-my-20-fr20my05-92","fr-2008-my-21-fr21my08-47","fr-2009-se-23-fr23se09-56","fr-2009-se-28-fr28se09-22","20070315-sfth004","20070624-lasu001","20071205-uktu106","63148102","fr-2009-se-28-fr28se09-11","20060627-phtu045","20060901-phf030","20060914-cgth005","20060424-clm518","20060627-nytu195","20060628-clw508","20060628-phw048","fr-2007-se-06-fr06se07-26","fr-2007-no-14-fr14no07-10","hearings-109-house-house-hearing-109-29333","hearings-109-senate-senate-hearing-109-27356","hearings-108-house-house-hearing-108-91647","cr-2004-oc-08-cr08oc04-127","310069","publication-14692-mit","hearings-107-senate-senate-hearing-107-78075","hearings-107-senate-senate-hearing-107-80397","hearings-111-house-house-hearing-111-52610"],"length":3,"score":-285.514901962644},{"text":"director counterterrorism division","docs":["presidential-2007-fe-14-presidential14fe07-176","cr-2004-my-18-cr18my04-182","cr-2003-jn-26-cr26jn03pt2-82","cr-2004-my-05-cr05my04-233","reports-111-house-house-report-111-347","fr-2000-de-26-fr26de00-87","hearings-108-house-house-hearing-108-98119","hearings-108-house-house-hearing-108-92334","hearings-109-house-house-hearing-109-21025","hearings-109-senate-senate-hearing-109-30597","hearings-108-house-house-hearing-108-93715","hearings-109-house-house-hearing-109-35626","hearings-110-house-house-hearing-110-35626","hearings-107-senate-senate-hearing-107-77601","hearings-107-senate-senate-hearing-107-81677","hearings-107-senate-senate-hearing-107-78538","reports-109-house-house-report-109-741","hearings-108-house-house-hearing-108-96990","hearings-107-senate-senate-hearing-107-77048","cr-2004-de-08-cr08de04-16","reports-108-house-house-report-108-724-pt5"],"length":3,"score":-277.367208893179},{"text":"regarding environmental conditions","docs":["fr-2005-au-30-fr30au05-50","hearings-107-senate-senate-hearing-107-80397","hearings-111-house-house-hearing-111-52610"],"length":3,"score":-275.550930020278}]')
      all_doc_names = []
      all_docs = {}
      for item in parsed_json['ngrams']
        all_doc_names.concat(item['docs'])
      end
      Document.find(:all, :conditions => {:doc_name => all_doc_names}).collect do |x| all_docs[x.doc_name] = x end
      @results = {:processedtxt => parsed_json['processedtxt'], :ngrams => []}
      for item in parsed_json['ngrams']
        context = '...was stopped before he could fly away, there were at least two significant lapses in the security response of allowed him to come close to making his escape, <span class="highlight">'+item['text']+'</span> officials of the Department of Homeland Security ....'
        @results[:ngrams] << {:text => item['text'], :docs => item['docs'].collect do |x| {:doc => all_docs[x], :context => context} end, :length => item['length'], :score => item['score']}
      end
      puts '*************************cde*************************'
    }
  end
  
  def temp
    open('http://www.yahoo.com/') {|f|
      @body = f.read
    }
  end
 
  def new_tool
    input_text = params[:input_text]
    render :json=>get_data_from_michael(input_text).to_json
  end

  def overall
    @corpus_id = 'bills cr fr hearings presidential reports prnewswire thehill aei brookings cato cfr cgdev civitas fraser nber ncpa rand urban'.split()
    @corpus_name = 'Bills,Congressional Records,Federal Register,Congressional Hearings,Presidential Records,Congressional Reports,PR Newswire,The Hill,AEI,Brookings,Cato,Center for Foreign Relations,Center for Global Development,Civitas,Fraser,National Bureau of Economic Research,National Center for Policy Analysis,Rand Corp.,Urban Institute'.split(',')
    @corpus_hash = {}
    @corpus_id.size.times { |i| @corpus_hash[ @corpus_id[i] ] = @corpus_name[i] }
    
    @doc_fields = 'corpus doc_id trackback_url published_time publisher author title keywords categories description type geo_region geo_place brooking_program prnewswire_su prnewswire_stock louisdb_congress louisdb_session louisdb_volume louisdb_section louisdb_chamber louisdb_type louisdb_number louisdb_version louisdb_startpage louisdb_endpage louisdb_speaker'.split()
    # @testjson = [1,3,4,5,'abc',{:key => "value", }].to_json()
    
    params[:doc_type] = 'documents' if not params.has_key?(:doc_type)
    # for cid in @corpus_id
    #   params[cid.to_sym] = 'off' if not params.has_key?(cid.to_sym)
    # end
    params[:corpus] = '' if not params.has_key?(:corpus)
    params[:length_min] = '3' if not params.has_key?(:length_min)
    params[:length_max] = '5' if not params.has_key?(:length_max)
    for str_field in 'title author ngrams_keyword date_from date_to'.split()
      params[str_field.to_sym] = '' if not params.has_key?(str_field.to_sym)
    end
    params[:documents_sort_order] = 'corpus' if not params.has_key?(:documents_sort_order)
    params[:documents_sort_direction] = 'asc' if not params.has_key?(:documents_sort_direction)
    params[:ngrams_sort_order] = 'text' if not params.has_key?(:ngrams_sort_order)
    params[:ngrams_sort_direction] = 'asc' if not params.has_key?(:ngrams_sort_direction)
    params[:start_index] = '1' if not params.has_key?(:start_index) or params[:start_index] == ''
    params[:rpp] = '100' if not params.has_key?(:rpp) or params[:rpp] == ''
    
    if params[:doc_type] == 'documents'
      @results = Document.find(:all, :conditions => ['corpus = :c', {:c => params[:corpus]}],  :offset => params[:start_index].to_i-1, :limit => params[:rpp].to_i)
    end
    
    if params[:doc_type] == 'ngrams'
      
    end
  end
   
  def process_data
    puts params
    render :json=>{:gopal=>'vaswani'}
  end
end
