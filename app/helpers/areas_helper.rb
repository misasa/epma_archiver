module AreasHelper
  def top_message
  	msgs = []
  	if @area.zip.path
	  	msgs << "This page summarizes a map analysis"
  		msgs << "on an area (#{@area.name})" if @area.name
  		msgs[-1] += "."
  		now_link = link_to("now",job_area_path(@area),:method => 'post',:data => { :confirm => "Are you sure you want to process #{@area.name} now?" })
  		#delete_link = link_to("within 1 hour",job_area_path(@area),:method => 'post',:data => { :confirm => "Are you sure you want to process #{@area.name} within 1 hour?" })
		delete_link = link_to("within 1 hour",area_path(@area),:method => 'delete',:data => { :confirm => "Are you sure you want to process #{@area.name} within 1 hour?" })
  		msgs << "Please download " + link_to("files", asset_path(@area.zip.url)) + " or reprocess " + now_link + " | " + delete_link + "."
  	else
  		msgs << "Processing ..."
  	end
  	raw(msgs.join(" "))

  end
end
