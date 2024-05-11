class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :post_code, :prefecture_id, :city, :street, :building, :phone_number

  with_options presence: true do
      #数字3桁、ハイフン、数字4桁の並びのみ保存できるようにする
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id
    validates :city
    validates :street
      #10桁以上11桁以内の半角数値のみ保存できるようにする
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Input only half-width numbers between 10 and 11 digits' }
    validates :token
  end

      #ジャンルの選択が「---」の時は保存できないようにする
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
      #購入情報をテーブルに保存し、変数orderへ代入する
    order = Order.create(user_id: user_id, item_id: item_id)
      #配送先の情報をテーブルに保存する
      #order_idは変数orderのidとして、テーブルに保存する
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street: street, building: building, phone_number: phone_number, order_id: order.id)
  end

end