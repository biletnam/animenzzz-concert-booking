class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@orders = current_user.orders
  end

  def show
  	@order = current_user.orders.find(params[:id])
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = current_user.orders.new(secure_params)

  	params[:seats].each do |seat_id|
  		@order.seats << Seat.find(seat_id)
  	end

  	redirect_to user_path(:user_id)
  end

  def destroy
  	@order = current_user.orders.find(params[:id])
  	@order.destroy
  end

  private

  def secure_params
  	params.require(:order).permit(:address, :phone, :name)
  end
end
