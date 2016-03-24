class VisitorsController < ApplicationController
  def index
  	@recitals = Recital.all.sort_by {|r| r.id }
  	videos = Video.arel_table
  	@indexVideo = Video.where(videos[:name].eq('Unravel (Tokyo Ghoul OP1)')).first
  	@videos = Video.where(videos[:name].not_eq('Unravel (Tokyo Ghoul OP1)'))
  end
end
