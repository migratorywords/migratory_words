module ProxySearcher
  def get_data_from_michael(text) 
    puts "============I am here baby==========="
    require 'open-uri'
    open(URI.encode('http://128.32.33.245:3003/mwords/get_data/?text='+ text)) do |f|
      parsed_json = ActiveSupport::JSON.decode(f.read)
      parsed_json['ngrams'].map! do |ngram|
        ngram['docs'] = Document.find(:all, :conditions => {:doc_name => ngram['docs']})
        ngram
      end
    end
  end
end 
