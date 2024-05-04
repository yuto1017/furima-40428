class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    #ログインしているユーザーが出品した商品で且つ、商品が売れている場合はトップページを表示する
    #下記の条件分岐は商品購入機能実装後に30行の条件分岐と差し替えするため、コメントアウト
    #if user_signed_in? && current_user.id == @item.user_id && @item.order == nil
    if user_signed_in? && current_user.id != @item.user_id
      redirect_to root_path
    #ログインしているユーザーが出品した商品でない場合、商品の販売状況に関係なくトップページを表示する
    #下記の条件分岐は商品購入機能実装後に追加するため、コメントアウト
    #elsif user_signed_in? && current_user.id != @item.user_id
      #redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @item.user_id
      @item.destroy
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_charge_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
