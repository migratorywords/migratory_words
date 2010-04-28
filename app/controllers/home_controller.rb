class HomeController < ApplicationController
  def index
  end
  
  def process_data
    puts params
    render :json=>{:gopal=>'vaswani'}
  end
end
