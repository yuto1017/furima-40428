require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
     # OrderDeliveryクラスのインスタンスを生成するときに、紐付くuserとitemをFactorybotを用いてデータを生成
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it "全ての入力項目が存在すれば購入できる" do
        expect(@order_delivery).to be_valid
      end
      it "buildingが空でも購入できる" do
        @order_delivery.building = nil
        expect(@order_delivery).to be_valid
      end
    end

    context '商品購入できない場合' do
      it "user_idが空では購入できない" do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it "item_idが空では購入できない" do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では購入できない" do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it "post_codeが空では購入ができない" do
        @order_delivery.post_code = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code can't be blank")
      end
      it "post_codeはハイフンがないと購入できない" do
        @order_delivery.post_code = "12345678"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "post_codeは数字3桁、ハイフン、数字4桁の並びでないと購入できない" do
        @order_delivery.post_code = "1234-567"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "prefecture_idが空では購入できない" do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "cityが空では購入できない" do
        @order_delivery.city = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it "streetが空では購入できない" do
        @order_delivery.street = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Street can't be blank")
      end
      it "phone_numberが空では購入できない" do
        @order_delivery.phone_number = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberが9桁以下では購入できない" do
        @order_delivery.phone_number = "123456789"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid. Input only half-width numbers between 10 and 11 digits")
      end
      it "phone_numberが12桁以上では購入できない" do
        @order_delivery.phone_number = "123456789000"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid. Input only half-width numbers between 10 and 11 digits")
      end
      it "phone_numberが半角数字以外では購入できない" do
        @order_delivery.phone_number = "あ"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid. Input only half-width numbers between 10 and 11 digits")
      end
    end
  end
end