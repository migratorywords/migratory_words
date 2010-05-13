class DocumentsController < ApplicationController
  def index
    if params[:corpora_id]
      @corpus = Corpus.find_by_id(params[:corpora_id].to_i)
      @documents = Document.find(:all, :conditions=>{:corpus_id=>params[:corpora_id].to_i})
    else
      @corpus = {:name=>"entire corpora"} 
      @documents = Document.find(:all)
    end
  end

  def get_docs_by_ngram
    ngram = params[:ngram]
    fuzzy = params[:fuzzy]
    begin
      open('http://128.32.33.245:3003/mwords/get_docs/?ngram='+URI.encode(ngram)) { |f|
        all_doc_ids = ActiveSupport::JSON.decode(f.read)
        all_doc_ids.map!{|x| x.to_i}
        selected_documents = Document.find(:all, :select => "id,corpus_id,trackback_url,published_time,author,title,corpus_id", :conditions => {:id => all_doc_ids})
        result = selected_documents.group_by{|x| x.published_time? ? x.published_time.year : 1900}
        render :json => {:documents => result, :error=>false}
      }
    rescue
      render :json => {:error=>true}
    end
  end
  
  def get_docs_with_context
    ngram = params[:ngram]
    doc_id = params[:doc_id]
    begin
      open('http://128.32.33.245:3003/mwords/get_context/?ngram='+URI.encode(ngram.strip())+'&doc_id='+URI.encode(doc_id)) { |f|
        response = ActiveSupport::JSON.decode(f.read)
        docs = Hash[*Document.find(response.keys).collect { |v| [v.id.to_s, {'corpus'=>v.corpus.long_name, 'trackback_url'=>v.trackback_url, 'published_time'=>v.published_time, 'title'=>v.title}] }.flatten]
        results = {}
        response.each{|k,v|
          results[k] = v.merge(docs[k])
        }
        render :json => results
      }
    rescue
      render :json => [{:doc_id => 123, :context => {:left=>'left side 1', :ngram => ngram, :right => 'right_side 1'}}, {:doc_id => 654750, :context => {:left=>'left side 1', :ngram => ngram, :right => 'right_side 1'}}]
    end
  end

  def get_context
    doc_id = params[:doc_id]
    ngram = params[:ngram]
    open('http://128.32.33.245:3003/mwords/get_context/?doc_id='+doc_id+'&ngram='+URI.encode(ngram)) { |f|
      render :json => ActiveSupport::JSON.decode(f.read)
    }
  end
end
