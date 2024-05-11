require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @order_delivery = FactoryBot.build(:order_delivery)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it "全ての入力項目が存在すれば購入できる" do
        expect(@order_delivery).to be_valid
      end
    end

    context '商品購入できない場合' do
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
      it "post_codeが空では購入ができない" do
        @order_delivery.post_code = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "post_codeが数字ハイフンがないと購入ができない" do
        @order_delivery.post_code = "12345678"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "post_codeが数字3桁、ハイフン、数字4桁の並びでないと購入ができない" do
        @order_delivery.post_code = "1234-567"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "prefecture_idが空では購入ができない" do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "cityが空では購入ができない" do
        @order_delivery.city = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it "streetが空では購入ができない" do
        @order_delivery.street = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Street can't be blank")
      end
      it "phone_numberが空では購入ができない" do
        @order_delivery.phone_number = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberが10桁以上11桁以内でないと購入ができない" do
        @order_delivery.phone_number = "1"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid. Input only half-width numbers between 10 and 11 digits")
      end
      it "phone_numberが半角数字以外では購入ができない" do
        @order_delivery.phone_number = "あ"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid. Input only half-width numbers between 10 and 11 digits")
      end
    end
  end
end