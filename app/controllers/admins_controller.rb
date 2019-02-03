class AdminsController < ApplicationController
  http_basic_authenticate_with name: 'admin247', password: 'secret!'
  def index
    @reviews = Review.all
  end
end
