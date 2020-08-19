class ItemsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:show, :edit, :update, :destroy]
  before_action :check_item_details, only: [:post_done, :update_done]
  before_action :condition, only: [:show]
  before_action :set_prefecture, only: [:show]
  before_action :delivery_fee, only: [:show]
  before_action :delivery_days, only: [:show]
  before_action :category_map, only: [:edit, :update]
  # before_action :set_ransack,only: [:search, :detail_search]

  def index
    @items = Item.all.order('id DESC').limit(3)
  end

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand

  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to  post_done_items_path
    else
      @item.images.new
      @item.build_brand
      render :new
    end
  end

  def post_done
    @item = Item.where(seller_id: current_user.id).last
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(@item.seller_id)
    if @user == current_user.id
      @item.destroy
      redirect_to  delete_done_items_path
    else
      flash.now[:alert] = '削除できませんでした'
      render :show
    end
  end

  def show
    if @item.quantity == 0
      redirect_to root_path
    # @seller = @items.seller.name
    end
  end

  def search
    @search_items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  private
  def condition
    @condition = Condition.find(@item.item_condition)
  end
   
  def set_prefecture
    @prefecture = PrefectureFire.find(@item.prefecture)
  end

  def delivery_fee
    @deliveryfee = DeliveryFee.find(@item.cost)
  end

  def delivery_days
    @deliverydays = DeliveryDays.find(@item.days)
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :item_condition, :price, :prefecture, :cost, :days,:brand_id, :quantity, images_attributes: [:id, :image, :_destroy], brand_attributes: [:id, :name ]).merge(seller_id: current_user.id)
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end

  def set_item
    
    @item = Item.find(params[:id])
  end

  def check_item_details
    @item = Item.where(seller_id: current_user.id).last
  end

  def show_all_instance
    @user = User.find(@item.seller_id)
    @images = Image.where(item_id: params[:id])
    @images_first = Image.where(item_id: params[:id]).first
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  def category_map
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
    else
      @parent_array = []
      @parent_array << @item.category.parent.parent.name
      @parent_array << @item.category.parent.parent.id
    end
    @category_children_array = Category.where(ancestry: child.ancestry)
    @child_array = []
    @child_array << child.name
    @child_array << child.id

    @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry)
    @grandchild_array = []
    @grandchild_array << grandchild.name
    @grandchild_array << grandchild.id
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to root_url if current_user != user
  end
end
