# users controller : Perform all the operationm related to user
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
