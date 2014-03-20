json.array!(@leagues) do |league|
  json.extract! league, :id, :name, :type, :groups_count, :teams_count
  json.url league_url(league, format: :json)
end
