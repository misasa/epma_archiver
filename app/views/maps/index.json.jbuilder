json.array!(@maps) do |map|
  json.extract! map, :id, :path, :area_id
  json.url map_url(map, format: :json)
end
