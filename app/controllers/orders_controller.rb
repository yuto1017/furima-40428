class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"] # gon GemでPAY.JPテスト公開鍵の環境変数をJavaScriptに変数を渡す
    #ログインしているユーザーが出品した商品でないで且つ、商品が売れていない場合は商品購入ページを表示する
    if user_signed_in? && current_user.id != @item.user_id && @item.order == nil
      @order_delivery = OrderDelivery.new
    #ログインしているユーザーが出品した商品でないで且つ、商品が売れている場合はトップページを表示する
    #ログインしているユーザーが出品した商品の場合、商品の販売状況に関係なくトップページを表示する
    #ログインアウトしている場合、商品の販売状況に関係なくトップページを表示する
    else
      redirect_to root_path
    end
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    #binding.pry
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"] # renderメソッドに対応するため、アクションを追加
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:post_code, :prefecture_id, :city, :street, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_order_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPテスト秘密鍵の環境変数
    Payjp::Charge.create(
      amount: @item.price,                  # 商品の値段
      card: order_params[:token],           # カードトークン
      currency:'jpy'                        # 通貨の種類（日本円）
    )
 end

end