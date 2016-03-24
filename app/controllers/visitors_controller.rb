class VisitorsController < ApplicationController
  def index
  	@recitals = Recital.all.sort_by {|r| r.id }
  	@indexVideo = Video.find 1
  	@videos = Video.where.not(id: '1')
  end
end
