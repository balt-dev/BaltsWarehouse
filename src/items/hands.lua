local function ensure_none_visible()
    if not G.GAME.hands["warehouse_none"] then
        G.GAME.hands["warehouse_none"] = {
            visible = false, order = 99,
            mult = 1, chips = 1, 
            s_mult = 1,  s_chips = 1,
            level = 1,
            l_mult = 0.5, l_chips = 5,
            played = 0, played_this_round = 0,
            example = {}
        }
    end
end

-- Fuck It.
local game_update = Game.update
function Game:update(dt)
    if G and G.GAME and G.GAME.hands and G.GAME.modifiers and G.GAME.modifiers.no_cards then
        ensure_none_visible()
    end
    return game_update(self, dt)
end

if not Cryptid then
    SMODS.PokerHand {
        key = "none",
        mult = 1, chips = 1,
        l_mult = 0.5, l_chips = 5,
        example = {},
        visible = function()
            return G.GAME.modifiers.no_cards
        end,
        evaluate = function(parts, hand)
            if G.GAME.modifiers.no_cards then
                return { hand }
            end
            return {}
        end
    }
end