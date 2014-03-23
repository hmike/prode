json.array!(@bets) do |bet|
  json.extract! bet, :id, :user_group_member_id, :match_id, :bet
  json.url bet_url(bet, format: :json)
end
