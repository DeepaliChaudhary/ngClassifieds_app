# users controller : Perform all the operationm related to user
require 'json'
class UsersController < ApplicationController
  #before_action :authenticate_user!, except: [:login_user]

  def index
  end

  ## Method : work as wrapper for Devise login method
  ## Params : user email id and password
  def login_user
    params['user'] = JSON.parse params['user']
    user = User.where(email: params['user']['email'])
    result = {status: 'failed', auth_token: ''}
    if user.present?
      @user = user.first
      if @user.valid_password?(params['user']['password'])
        sign_in(user.first)
        auth_token = @user.auth_token
        result[:auth_token] = auth_token
        result[:status] = 'success'
      end
    end
      render :json => result
  end
end
