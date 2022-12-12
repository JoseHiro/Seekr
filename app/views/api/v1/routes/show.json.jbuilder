json.array! @businesses do |restaurant|
  json.extract! business, :latitude, :longitude
end
