class AggregationController < ApplicationController
  def index
  	@orders = Order.joins(seats: [area: [:recital]]).where(recitals: {city: "武汉"}, areas: {name: ["贵宾1包厢", "贵宾2包厢", "贵宾3包厢", "贵宾4包厢", "1楼1号包厢", "1楼2号包厢", "1楼3号包厢", "1楼4号包厢"]}).distinct
  end
end