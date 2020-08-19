class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    # @item_purchase = ItemPurchase.new
  end
  def create
    @purchase = ItemPurchase.new(user_id: current_user.id, item_id: params[:item_id], postal_code: purchase_params[:postal_code], prefecture_id: purchase_params[:prefecture_id], city: purchase_params[:city], house_number: purchase_params[:house_number], building_name: purchase_params[:building_name], telephone_number: purchase_params[:telephone_number])
    if @purchase.valid?
      pay_item
      @purchase.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    item = Item.find(purchase_params[:item_id])
    Payjp::Charge.create(
      amount: item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
