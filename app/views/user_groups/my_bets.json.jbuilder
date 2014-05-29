json.array!(@bets) do |bet|
	json.match do
		json.id bet[0]
	end
	if bet[1].nil?
		json.bet nil
	else
		    # t.integer  "user_group_member_id"
		    # t.integer  "match_id"
		    # t.integer  "bet"
		    # t.datetime "created_at"
		    # t.datetime "updated_at"
		json.bet do
			json.id bet[1].id
			json.match_id bet[1].match_id
			json.bet bet[1].bet
			json.bet_label bet[1].bet_label
			json.win bet[1].win
			json.score bet[1].score
		end
	end
end