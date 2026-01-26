SMODS.Joker {
	key = "sorcerer",
	rarity = 2,
	atlas = "warehouse_jokers", pos = {x = 2, y = 0},
	config = { extra = {per_mult = 8} },
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.per_mult,
			card.ability.extra.per_mult * (
				G.GAME.consumeable_usage_total and
				G.GAME.consumeable_usage_total.spectral or 0
			)
		}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.per_mult * (
					G.GAME.consumeable_usage_total and
					G.GAME.consumeable_usage_total.spectral or 0
				)
			}
		end
		if
			context.using_consumeable and
			context.consumeable.config.center.set == "Spectral"
		then
			return { message = localize "k_upgrade_ex" }
		end
	end
}


SMODS.Joker {
	key = "bartender",
	rarity = 2,
	atlas = "warehouse_jokers", pos = {x = 1, y = 0},
	config = { extra = {extra_discard = 1, hand_size = -1} },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.extra_discard, card.ability.extra.hand_size}}
	end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_discard_limit(card.ability.extra.extra_discard)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_discard_limit(-card.ability.extra.extra_discard)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
}

SMODS.Joker {
	key = "librarian",
	rarity = 1,
	config = { extra = {per_card = 5} },
	atlas = "warehouse_jokers", pos = {x = 0, y = 0},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.per_card,
			card.ability.extra.per_card * ((G.GAME.unique_scored_cards and G.GAME.unique_scored_cards.count) or 0)
		}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips =
					card.ability.extra.per_card * ((
						G.GAME.unique_scored_cards and G.GAME.unique_scored_cards.count)
					or 0)
			}
		end
		if context.unique_card then
			return { message = localize "k_upgrade_ex" }
		end
	end
}

SMODS.Joker {
	key = "grater",
	rarity = 2,
	pos = {x = 0, y = 0},
    config = { extra = { mult = 21 } },
    loc_vars = function(self, info_queue, card)
		table.insert(info_queue, { set = "Other", key = "warehouse_placeholder" })
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and
            (context.other_card:get_id() == 3 or context.other_card:get_id() == 6) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
	key = "golden_pearl",
	rarity = 3,
	pos = {x = 0, y = 0},
    config = { extra = 10 },
    loc_vars = function(self, info_queue, card)
		table.insert(info_queue, { set = "Other", key = "warehouse_placeholder" })
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if
    		context.before and
    		context.scoring_name == 'High Card' and
    		#context.full_hand == 2
		then
			local king, queen = nil, nil
			for i, card in ipairs(G.play.cards) do
				if card:get_id() == 13 and not king then
					king = card
				end
				if card:get_id() == 12 and not queen then
					queen = card
				end
			end
			if king and queen then
				SMODS.destroy_cards(queen)
	            king.ability.perma_mult = king.ability.perma_mult or 0
	            king.ability.perma_mult = king.ability.perma_mult + card.ability.extra
	            return {
	                message = localize('k_upgrade_ex'), colour = G.C.MULT, message_card = king
	            }
			end
        end
    end
}


if not Cryptid then
	SMODS.Joker {
		key = "broken",
		rarity = 1,
		config = { chips = 75, type = 'warehouse_none' },
		atlas = "warehouse_jokers", pos = {x = 1, y = 1},
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.chips, localize(card.ability.type, 'poker_hands') } }
		end,
		calculate = function(self, card, context)
			if context.joker_main and context.scoring_name == card.ability.type then
				return { chips = card.ability.chips }
			end
		end
	}
	SMODS.Joker {
		key = "missing",
		rarity = 1,
		config = { mult = 10, type = 'warehouse_none' },
		atlas = "warehouse_jokers", pos = {x = 0, y = 1},
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.mult, localize(card.ability.type, 'poker_hands') } }
		end,
		calculate = function(self, card, context)
			if context.joker_main and context.scoring_name == card.ability.type then
				return { mult = card.ability.mult }
			end
		end
	}
	SMODS.Joker {
		key = "the_emptiness",
		rarity = 3,
		config = { h_x_mult = 3, type = 'warehouse_none' },
		atlas = "warehouse_jokers", pos = {x = 2, y = 1},
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.h_x_mult, localize(card.ability.type, 'poker_hands') } }
		end,
		calculate = function(self, card, context)
			if context.joker_main and context.scoring_name == card.ability.type then
				return { Xmult = card.ability.h_x_mult }
			end
		end
	}
end