class PurchasesController < ApplicationController
  before_action :move_to_sign_in, only: [:index]
  before_action :move_to_index, only: [:index]
  def index
    @item = Item.find(params[:item_id])
    @item_purchase = ItemPurchase.new
  end
  def create
    @item = Item.find(params[:item_id])
    @item_purchase = ItemPurchase.new(purchase_params)
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:item_purchase).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    item = Item.find(params[:item_id])
    Payjp::Charge.create(
      amount: item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def move_to_index
    if (current_user.id == Item.find(params[:item_id]).user_id) || (Item.find(params[:item_id]).purchase.present?)
      redirect_to root_path
    end
  end
end
