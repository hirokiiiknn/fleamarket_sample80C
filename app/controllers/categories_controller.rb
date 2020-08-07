class CategoriesController < ApplicationController
  def index
    @parents = Category.all.order("id ASC").limit(40)
  end

  
  
end
