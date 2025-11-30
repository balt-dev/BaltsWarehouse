SMODS.Consumable {
	key = "do_over",
	set = "Spectral",
	atlas = "warehouse_consumables", pos = { x = 0, y = 0 },
	config = { extra = { reset = 0, pull_from_packs = true } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.reset } }
	end,
	use = function(self, card, area)
		ease_discard(G.GAME.round_resets.discards - G.GAME.current_round.discards_left)
		ease_hands_played(G.GAME.round_resets.hands - G.GAME.current_round.hands_left)

		G.E_MANAGER:add_event(Event({
			trigger = 'ease',
			blocking = false,
			ref_table = G.GAME,
			ref_value = 'chips',
			ease_to = 0,
			delay = 0.5,
			func = (function(t) return math.floor(t) end)
		}))
		G.FUNCS.draw_from_hand_to_discard()
		G.FUNCS.draw_from_discard_to_deck()
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			blocking = false,
			func = (
				function()
					if #G.deck.cards < G.deck.config.card_limit then return false end
					G.deck:shuffle('doover_'..card.unique_val)
                    G.deck:hard_set_T()
					G.FUNCS.draw_from_deck_to_hand()

					return true
				end)
		}))
	end,
	can_use = function(self, card)
		return G.STATE == G.STATES.SELECTING_HAND
	end
}

SMODS.Consumable {
	key = "apparition",
	set = "Spectral",
	pos = { x = 5, y = 2 }, --atlas = "warehouse_spectrals", 
	config = { extra = 1 },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, { set = "Other", key = "warehouse_placeholder" })
		--table.insert(info_queue, { set = "Edition", key = "e_negative_playing_card" })
        return { vars = { card.ability.extra } }
    end,
    use = function(self, card, area, copier)
    	local target_count = math.ceil(card.ability.extra)
    	
        local potential_targets = {}
        local targets = {}
        for _, card in ipairs(G.playing_cards) do
        		-- Copy table
            potential_targets[#potential_targets + 1] = card
        end
        for i = 1, target_count do
            if G.playing_cards[i] then
                local target, idx = pseudorandom_element(potential_targets, 'warehouse_apparition')
                targets[#targets + 1] = target
                table.remove(potential_targets, idx)
            end
        end
        for i, target in ipairs(targets) do
        		G.E_MANAGER:add_event(Event({
            		func = function()
                	target:juice_up(0.3, 0.5)
                	target:set_edition({negative = true}, true)
                	return true
            		end
        		}))
        	end
    end,
	can_use = function(self, card)
		return true
	end
}

SMODS.Consumable {
	key = "hyperdrive",
	set = "Spectral",
	atlas = "warehouse_consumables", pos = { x = 1, y = 0 },
	config = { extra = { seal = 'warehouse_pink' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}
