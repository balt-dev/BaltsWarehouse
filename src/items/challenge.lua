

SMODS.Challenge {
    key = "cardless",
    rules = {
        custom = {
            {id = "no_cards", value = true},
            {id = "zero_card", value = nil},
            {id = "start_shop_tag", value = nil},
        },
        modifiers =  {
            {id = "hand_size", value = 0},
            {id = "dollars", value = 20},
        },
    },
    tags = {
        { id = "tag_warehouse_shop" }
    },
    consumeables = {
        (Cryptid and { id = "c_cry_nibiru" }) or {id = "c_warehouse_nothing"},
        (Cryptid and { id = "c_cry_nibiru" }) or {id = "c_warehouse_nothing"},
    },
    deck = {
        type = 'Challenge Deck',
        cards = {}
    },
    restrictions = {
        banned_cards = {
        },
        banned_other = {
            { id = "bl_window", type = "blind" },
            { id = "bl_wheel", type = "blind" },
            { id = "bl_tooth", type = "blind" },
            { id = "bl_serpent", type = "blind" },
            { id = "bl_psychic", type = "blind" },
            { id = "bl_plant", type = "blind" },
            { id = "bl_pillar", type = "blind" },
            { id = "bl_ox", type = "blind" },
            { id = "bl_mouth", type = "blind" },
            { id = "bl_mark", type = "blind" },
            { id = "bl_house", type = "blind" },
            { id = "bl_head", type = "blind" },
            { id = "bl_goad", type = "blind" },
            { id = "bl_fish", type = "blind" },
            { id = "bl_final_bell", type = "blind" },
            { id = "bl_eye", type = "blind" },
            { id = "bl_club", type = "blind" },
        }
    },
    apply = function()
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 0.5,
            func = function()
                add_tag(Tag('tag_warehouse_shop'))
                return true
            end
        })
    end
}

local sel_blind = G.FUNCS.select_blind

G.FUNCS.select_blind = function(...)
    return sel_blind(...)
end

local play_hl = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    G.hand:parse_highlighted()
    return play_hl(e)
end


-- Fuck It.
local game_update = Game.update
function Game:update(dt)
    if G and G.GAME and G.GAME.modifiers and G.GAME.modifiers.no_cards then
        if G.deck then SMODS.destroy_cards(G.deck.cards, true, true) end
        if G.hand then SMODS.destroy_cards(G.hand.cards, true, true) end
        if G.discard then SMODS.destroy_cards(G.discard.cards, true, true) end
    end
    return game_update(self, dt)
end