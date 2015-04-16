json.array!(@areas) do |area|
  json.extract! area, :id, :name, :path
  json.url area_url(area, format: :json)
end
