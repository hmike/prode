json.array!(@matches) do |match|
  json.extract! match, :id, :league_id, :date, :local_team_id, :away_team_id, :local_score, :away_score, :league_date
  json.url match_url(match, format: :json)
end
