json.array!(@teams) do |team|
  json.extract! team, :id, :name, :code, :country, :avatar
  json.url team_url(team, format: :json)
end
