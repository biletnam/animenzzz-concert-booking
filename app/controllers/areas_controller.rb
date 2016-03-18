class AreasController < ApplicationController

  def index
  	@recital = Recital.find params[:recital_id]
  	@areas = @recital.areas
  end

  def show
  	@recital = Recital.find params[:recital_id]
  	@area = @recital.areas.find(params[:id])
  end

  def create
    cd = JSON.parse(params[:data])
    cd.each do |floor| 
      floor.each do |areas|
      	areas.each do |area|
      	  next if area[:type] == 'empty'
      	  seat = Seat.create(locate_x: area[:row], locate_y: area[:num])
      	  price = Price.where { :price => area[:price] }
      	  price.seats << seat
      	  price.save
      	  a = Area.where { :klass => area[:area] }
      	  a << seat 
      	  a.save
      	end 
      end
    end 
  end
end