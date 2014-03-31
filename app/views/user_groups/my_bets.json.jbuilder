json.array!(@bets) do |bet|
	json.match bet[0]
	json.bet bet[1]
end