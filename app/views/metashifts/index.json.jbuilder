json.array!(@metashifts) do |metashift|
  json.extract! metashift, :id, :category, :description, :multiplier
  json.url metashift_url(metashift, format: :json)
end
