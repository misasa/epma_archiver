class TopController < ApplicationController
  def index
  	params[:q] = Hash.new unless params[:q]
  	if params[:from] && params[:to]
  		params[:q][:maps_mtime_gteq] = params[:from]
  		params[:q][:maps_mtime_lteq] = params[:to]  		
  	end
    @q = Area.search(params[:q])
    @areas = @q.result.includes(:maps)

  end
end
