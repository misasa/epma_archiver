class TopController < ApplicationController
  def index
  	params[:q] = Hash.new unless params[:q]
#  	params[:q][:s] = 'maps_mtime desc'
  	if params[:from] && params[:to]
  		params[:q][:maps_mtime_gteq] = params[:from]
  		params[:q][:maps_mtime_lteq] = params[:to]  		
  	end
    @q = Area.search(params[:q])
    @areas = @q.result(distinct: true).includes(:maps)

  end
end
