
function idx_id(area, index)
	local idx = 0
	for i, card in ipairs(area.cards) do
		if card.highlighted then
			idx = idx + 1
		end
		if idx == index then
			return card:get_id()
		end
	end
	return 
end

local FUNCS_get_poker_hand_info = G.FUNCS.get_poker_hand_info
G.FUNCS.get_poker_hand_info = function(cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = FUNCS_get_poker_hand_info(cards)
	if #cards > 0 then
		local area = cards[1].area
		if #cards == 4 and
			idx_id(area, 1) == 3 and
			idx_id(area, 2) == 6 and
			idx_id(area, 3) == 2 and
			idx_id(area, 4) == 14
		then
			loc_disp_text = 'I know what you are.'
		end
		if #cards == 2 and
			idx_id(area, 1) == 6 and
			idx_id(area, 2) == 9
		then
			loc_disp_text = 'Nice.'
		end
		if #cards == 2 and
			idx_id(area, 1) == 6 and
			idx_id(area, 2) == 7
		then
			loc_disp_text = 'No.'
		end
		if #cards == 5 and
			idx_id(area, 1) == 14 and
			idx_id(area, 2) == 14 and
			idx_id(area, 3) == 14 and
			idx_id(area, 4) == 14 and
			idx_id(area, 5) == 14
		then
			loc_disp_text = 'Boo!'
		end
	end
	return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end
