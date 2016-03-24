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
      #classified_params['categories'] = JSON.parse classified_params['categories']
      #classified_params['contact'] = JSON.parse classified_params['contact']
      @classified = Classified.new(classified_params)
      if @classified.save!
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

    classified_params = JSON.parse params[:classified]
    classified_params['created_at'] = DateTime.parse(classified_params['created_at'])
    classified_params['updated_at'] = DateTime.parse(classified_params['updated_at'])

    @classified = Classified.where(params[:id]).first
    result = update_classified(classified_params)    
    
    render :json => result    
  end

  def update_classified(classified_params)
    result = {status: 'failed', classified: ''}
    @classified.title = classified_params['title']
    @classified.description = classified_params['description']
    @classified.price = classified_params['price']
    @classified.posted = classified_params['posted']
    @classified.contact = classified_params['contact']
    @classified.categories = classified_params['categories']
    @classified.image = classified_params['image']
    @classified.views = classified_params['views']
    if @classified.save
      @updated_classified = Classified.where(params[:id]).first
      result = {status: 'success', classified: @updated_classified}
    end
    return result
  end

  private

  def classifieds_params
    params.require(:classified).permit!
  end
end
