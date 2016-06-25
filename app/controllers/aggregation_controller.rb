class AggregationController < ApplicationController
  before_action :authenticate_user!
  def index
  	if not current_user.admin?
  	  flash[:alert] = I18n.t('Not a administrator')
  	  redirect_to root_path
  	end
  	if params[:city] != '' and params[:row] != '' and params[:col] != ''
  	  @orders = Order.joins(seats: [area: [:recital]]).where(recitals: {city: params[:city]}, areas: {name: params[:area]}, seats: {locate_x: params[:row], locate_y: params[:col]})
  	elsif params[:city] != ''
  	  @orders = Order.joins(seats: [area: [:recital]]).where(recitals: {city: params[:city]})
  	end
  end
end