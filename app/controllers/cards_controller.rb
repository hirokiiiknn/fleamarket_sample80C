 # 〜〜〜〜〜〜〜〜〜〜〜馬場元々のコードここから〜〜〜〜〜〜〜〜〜〜〜
# class CardController < ApplicationController

#   require "payjp"

  # def new
  #   card = Card.where(user_id: current_user.id)
  #   redirect_to card_index_path if card.exists?
  # end

 
  # def pay #payjpとCardのデータベース作成を実施します。
  #   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #   if params['payjp-token'].blank?
  #     redirect_to new_card_path
  #   else
  #     customer = Payjp::Customer.create(
  #     # description: '登録テスト', #なくてもOK
  #     # email: current_user.email, #なくてもOK
  #     card: params['payjp-token'],
  #     # metadata: {user_id: current_user.id}
  #     ) #念の為metadataにuser_idを入れましたがなくてもOK
  #     @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      
  #     if @card.save
  #       redirect_to card_index_path
  #     else
  #       redirect_to pay_card_index_path
  #     end
  #   end
  # end

  # def delete #PayjpとCardデータベースを削除します
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #   else
  #     Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     customer.delete
  #     card.delete
  #   end
  #     redirect_to new_card_path
  # end
    # def show #Cardのデータpayjpに送り情報を取り出します
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #     redirect_to new_card_path
  #   else
  #     Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end
# end
  # 〜〜〜〜〜〜〜〜〜〜〜馬場元々のコードここまで〜〜〜〜〜〜〜〜〜〜〜〜
  
  class CardsController < ApplicationController
    require 'payjp'
  
    before_action :set_item, only:[:show,:pay]
    before_action :card_present,only:[:index,:destroy]
    before_action :take_card, only:[:show,:pay]
    before_action :set_api_key
    
    # def new
      # card = Card.where(user_id: current_user.id)
      # redirect_to card_index_path if card.exists?
    # end

    def create
      if params['payjp-token'].blank?
        redirect_to action: "new"
        # トークンが取得出来てなければループ
      else
        user_id = current_user.id
        customer = Payjp::Customer.create(
        card: params['payjp-token']
        # params['payjp-token']（response.id）からcustomerを作成
        ) 
        @card = Card.new(user_id: user_id, customer_id: customer.id, card_id: customer.default_card)
        if @card.save
          flash[:notice] = '登録しました'
          redirect_to "/"
        else
          flash[:alert] = '登録できませんでした'
          redirect_to action: "new"
        end
      end
    end

    def destroy #PayjpとCardのデータベースを削除
      set_customer
      @customer.delete
      if @card.destroy #削除に成功した時にポップアップを表示します。
        flash[:notice2] = '削除しました'
        redirect_to action: "index"
      else #削除に失敗した時にアラートを表示します。
        flash[:alert2] = '削除できませんでした'
        redirect_to action: "index"
      end
    end

    def show 
      if @card.blank?
        #登録された情報がない場合にカード登録画面に移動
        flash[:alert] = '購入前にカード登録してください'
        redirect_to cards_path and return
      else
        #保管した顧客IDでpayjpから情報取得
        set_customer
        #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
        set_card_information
      end
      if current_user.prefecture == nil
          flash[:alert] = '購入前に住所登録してください'
          redirect_to new_prefecture_path
      end
    end

    def pay
      @item.update(buyer_id: current_user.id)
      # 現在のユーザーを購入者に登録
      Payjp::Charge.create(
      :amount => @item.price, 
      :customer => @card.customer_id, 
      :currency => 'jpy', #日本円
     )
      redirect_to item_purchase_index_path(@item.id)
    # 購入確認画面に遷移
    end

  
  private
  
    def set_item
      @item = Item.find(params[:id])
      @prefecture = Prefecture.find_by(user_id:current_user.id)
    end

    def card_present
      @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
    end
  
    def set_api_key
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
    end
  
    def set_customer
      @customer = Payjp::Customer.retrieve(@card.customer_id)
    end
  
    def set_card_information
      @card_information = @customer.cards.retrieve(@card.card_id)
    end
  
    def take_card
      @card = Card.find_by(user_id: current_user.id)
    end
  
  end
