class CategoriesController < ApplicationController
  def index
    @parents = Category.all
  end

  def show
  end
  
  
end
