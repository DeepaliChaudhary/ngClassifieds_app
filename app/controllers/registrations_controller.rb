require 'securerandom'
require 'json'
class RegistrationsController < ApplicationController
  def create
    puts '*** registration create'
    #build_resource(params)
    result = {status: 'failed', auth_token: ''}
    params['user'] = JSON.parse params['user']
    user = User.new({email:  params['user']['email'], password:  params['user']['password']})
    if user.save!
      auth_token = SecureRandom.hex(13)
      user.auth_token = auth_token
      user.save
      sign_in user
      result[:auth_token] = auth_token
      result[:status] = 'success'
    end
     render :json => result
  end

  # def after_sign_up_path_for(resource)
  #   resource.update_coulmns({auth_token: 'aaaaa8738947'})
  # end
end
