if not Cryptid then
  SMODS.Consumable {
    key = "nothing",
    set = "Planet",
    cost = 3,
    atlas = "warehouse_consumables", pos = { x = 0, y = 1 },
    config = { hand_type = 'warehouse_none', softlock = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
            }
        }
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_deep_space'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Planet.text_colour,
            1.2)
    end
}
end