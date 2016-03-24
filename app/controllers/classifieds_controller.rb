# Controller to perform various operations on classifieds
require 'json'
class ClassifiedsController < ApplicationController
  def index
    result = {status: 'failed', data: []}
    begin
      @classifieds = Classified.all
      result[:status] = 'success'
      result[:data] = @classifieds      
    rescue Exception => ex
    end
    render :json => result
  end

  def new
    @classified = Classified.new
  end

  def create
    status = 'failed'
    begin
      classified_params = JSON.parse  params[:classified]
      @classified = Classified.new(classified_params)
      if @classified.save
        #redirect_to classifieds_path
        status = 'success'
      end
    rescue Exception => e
    end
    render :json => {status: status}
  end

  def show
    result = {status: 'failed', classified: []}
    begin
      @classified = Classified.find(params[:id])
      result[:status] = 'success'
      result[:classified] = @classified
    rescue Exception => e      
    end
    render :json => result
  end

  def update
    puts '**** update', params
    classified_params = JSON.parse params
    puts '***', classified_params
    @classified = Classified.find(params[:id])
    puts @classified.inspect
    if @classified.update(classifieds_params)
      render :json => {status: 'success'}  
    else
      render :json => {status: 'failed'}
    end
    
  end

  private

  def classifieds_params
    params.require(:classified).permit!
  end
end
