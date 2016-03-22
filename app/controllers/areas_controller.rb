class AreasController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
  	@recital = Recital.find params[:recital_id]
  	# @areas = @recital.areas
  	@recital.areas.each do |area|
  	  area.seats.each do |seat|
  	  	@seats << seat if seat.sold
  	  end
  	end
  end

  # def show
  # 	@recital = Recital.find params[:recital_id]
  # 	@area = @recital.areas.find(params[:id])
  # end

  def create
    cd = params[:data]
    cd.each do |floor| 
      floor.each do |areas|
      	areas.each do |area|
      	  next if area[:type] != 'seat'
      	  seat = Seat.create(locate_x: area[:row], locate_y: area[:num])
      	  price = Price.where(:price => area[:price]).first
      	  price.seats << seat
      	  price.save
      	  a = Area.where(:klass => area[:area]).first
      	  a.seats << seat 
      	  a.save
      	end 
      end
    end 
  end
end
