class DocumentsController < ApplicationController
  def index
    @documents = Document.find(:all, :conditions=>{:author => "Maurel & Prom"}) 
  end
end
