class TopController < ApplicationController
  def index
  	@session_name = params[:session_name]
  	@session_id = params[:session_id]
  	params[:q] = Hash.new unless params[:q]
  	params[:q][:s] = 'mtime desc'
  	if params[:from] && params[:to]
  		params[:q][:mtime_gteq] = params[:from]
  		params[:q][:mtime_lteq] = params[:to]  		
  	end
    @q = Area.search(params[:q])
    @areas = @q.result(distinct: true).page(params[:page])

  end
end
