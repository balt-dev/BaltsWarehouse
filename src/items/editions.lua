SMODS.Edition {
	key = "stellar",
	shader = "stellar",
	extra_cost = 4,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	weight = 15,
	sound = { sound = "whoosh1", per = 2, vol = 0.6 },
	in_shop = true,
	calculate = function(self, card, context)
		if
			(context.before or context.after) and
			card.area ~= G.hand and
			(card.area ~= G.play or card.highlighted)
		then
			if context.before then G.GAME.current_round.stellar_levels = (G.GAME.current_round.stellar_levels or 0) + 1 end
			G.E_MANAGER:add_event(Event{
				func = function()
					card:juice_up(0.6, 0.6)
					return true
				end
			})
		end
	end
}