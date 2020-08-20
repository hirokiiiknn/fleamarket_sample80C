class CardsController < ApplicationController
  # before_action :correct_user, only: [:buy, :pay]
  before_action :move_to_root
  before_action :prefecture,   only: [:buy, :pay]
  before_action :set_card,    only: [:new, :show, :destroy, :buy, :pay]
  before_action :set_item,    only: [:buy, :pay]
  
  require "payjp"

  def new
    redirect_to card_path(current_user.id) if @card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    if params['payjp-token'].blank?
      # payjp-tokenが空ならnewへ
      redirect_to new_card_path
    else
      # payjp-tokenが入っているなら以下を実施
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to registration_done_cards_path
      else
        redirect_to new_card_path
      end
    end
  end

  def registration_done
  end

  def show
    if @card.blank?
    #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path 
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(@card.card_id)
      case @card_info.brand
        when "Visa"
          @card_src = "visa.gif"
        when "JCB"
          @card_src = "jcb.gif"
        when "MasterCard"
          @card_src = "mc.png"
        when "American Express"
          @card_src = "amex.gif"
        when "Diners Club"
          @card_src = "diners.gif"
        when "Discover"
          @card_src = "discover.gif"
      end
    end
  end

  def destroy
    if @card.blank?
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to delete_done_cards_path
  end

  def delete_done
  end

  def buy
    if user_signed_in?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      if @card.blank?
        @card_info = ""
      else
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @card_info = customer.cards.retrieve(@card.card_id)
        case @card_info.brand
          when "Visa"
            @card_src = "visa.gif"
          when "JCB"
            @card_src = "jcb.gif"
          when "MasterCard"
            @card_src = "mc.png"
          when "American Express"
            @card_src = "amex.gif"
          when "Diners Club"
            @card_src = "diners.gif"
          when "Discover"
            @card_src = "discover.gif"
        end
      end
    else
      redirect_to root_path
    end
  end

  def pay
    # if @item.auction_status == "売り切れ"
    if @item.quantity == 0
      redirect_to buy_card_path(@item)
    else
      if current_user.card.present?
        Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
        charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        @item.update!(buyer_id: 2)
        # 仮テスト 0817追記↓↓↓↓↓↓↓↓↓
        @item.update!(quantity: @item.quantity = @item.quantity - 1)
      else
        Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'],
          currency: 'jpy'
          )
        @item.update!(buyer_id: 2)
        # 仮テスト 0817追記↓↓↓↓↓↓↓↓↓
        @item.update!(quantity: @item.quantity = @item.quantity - 1)
      end
    end
  end

  private

  def prefecture
    # @destinations = Destination.all
    @prefecture = PrefectureFire.find(current_user.destination.prefecture)
  end

  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to root_url if current_user == user
  end
  
end

# コードレビュー待ち
# 加藤