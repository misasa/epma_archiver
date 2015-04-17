module ApplicationHelper
  def map_line_for(area, style = :thumb )
    a = []
    area.maps.each do |map|
    	next unless map.image
    	image_url = map.image.url(style)
    	next unless image_url
    	image_path = map.image.path(style)
    	next unless image_path
      	if image_url && File.exist?(image_path)
        #	a << link_to(image_tag(image_url), map_path(map))
        	tag = link_to(image_tag(image_url), map_path(map))
        	tag += content_tag(:div, map.element_name , :class => "caption")   
        	#tag = content_tag(:div, tag, :class => "thumbnail")
        	tag = content_tag(:div, tag, :class => "col-lg-1")
        	a << tag
      	end	
    end
  	a.join
  end

  def map_tile_for(area, style = :thumb )
    a = []
    area.maps.each do |map|
    	next unless map.image
    	image_url = map.image.url(style)
    	next unless image_url
    	image_path = map.image.path(style)
    	next unless image_path
      	if image_url && File.exist?(image_path)
        #	a << link_to(image_tag(image_url), map_path(map))
        	tag = link_to(image_tag(image_url), map_path(map))
        	tag += content_tag(:div, map.element_name , :class => "caption")   
        	tag = content_tag(:div, tag, :class => "thumbnail")
        	tag = content_tag(:div, tag, :class => "col-lg-2")
        	a << tag
      	end	
    end
  	a.join
  end


end

