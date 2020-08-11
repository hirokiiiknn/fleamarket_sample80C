class ItemsController < ApplicationController
  def index
    @items = Item.joins(:images).select('items.*, images.image')
  end

  def show
  
  end

end
