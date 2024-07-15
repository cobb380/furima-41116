class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :set_order, only: [:index]
  before_action :check_user, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_order
    @order = Order.find_by(item_id: @item.id)
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = 'sk_test_20989e1502fc9389149bddd1' # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def check_user
    if current_user.nil?
      redirect_to new_user_session_path
    elsif current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end
end
