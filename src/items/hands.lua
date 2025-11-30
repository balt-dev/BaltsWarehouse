if not Cryptid then
    local game_update = Game.update
    function Game:update(dt)
        if G and G.GAME and G.GAME.hands and not G.GAME.hands["warehouse_none"] then
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
        return game_update(self, dt)
    end

    SMODS.PokerHand {
        key = "none",
        mult = 1, chips = 1,
        l_mult = 0.5, l_chips = 3,
        example = {},
        evaluate = function(parts, hand)
            return { hand }
        end
    }
end