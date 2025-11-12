

SMODS.Challenge {
    key = "cardless",
    rules = {
        custom = {
            {id = "no_cards", value = true},
            {id = "zero_card", value = nil},
            {id = "win_ante", value = 10}
        },
        modifiers =  {
            {id = "hand_size", value = 0},
        },
    },
    jokers = {
        { id = "j_ice_cream" }
    },
    consumeables = {
        Cryptid and { id = "c_cry_nibiru" },
        Cryptid and { id = "c_cry_nibiru" }
    },
    deck = {
        type = 'Challenge Deck',
        cards = {}
    },
    restrictions = {
        banned_cards = {
            { id = "j_8_ball" },
            { id = "j_ancient" },
            { id = "j_arrowhead" },
            { id = "j_baron" },
            { id = "j_blackboard" },
            { id = "j_bloodstone" },
            { id = "j_blue_joker" },
            { id = "j_business" },
            { id = "j_castle" },
            { id = "j_certificate" },
            { id = "j_clever" },
            { id = "j_cloud_9" },
            { id = "j_crafty" },
            { id = "j_crazy" },
            { id = "j_devious"},
            { id = "j_delayed_grat" },
            { id = "j_dna" },
            { id = "j_drivers_license" },
            { id = "j_droll" },
            { id = "j_duo" },
            { id = "j_dusk" },
            { id = "j_erosion" },
            { id = "j_even_steven" },
            { id = "j_faceless" },
            { id = "j_family" },
            { id = "j_fibonacci" },
            { id = "j_flower_pot" },
            { id = "j_four_fingers" },
            { id = "j_gluttenous_joker"},
            { id = "j_greedy_joker"},
            { id = "j_green_joker"},
            { id = "j_hack"},
            { id = "j_hanging_chad" },
            { id = "j_hiker"},
            { id = "j_hit_the_road"},
            { id = "j_hologram"},
            { id = "j_idol"},
            { id = "j_jolly"},
            { id = "j_lucky_cat"},
            { id = "j_lusty_joker"},
            { id = "j_mad"},
            { id = "j_mail"},
            { id = "j_marble"},
            { id = "j_midas_mask"},
            { id = "j_mime"},
            { id = "j_odd_todd"},
            { id = "j_onyx_agate"},
            { id = "j_order"},
            { id = "j_pareidolia"},
            { id = "j_photograph"},
            { id = "j_raised_fist"},
            { id = "j_ramen"},
            { id = "j_reserved_parking"},
            { id = "j_ride_the_bus"},
            { id = "j_rough_gem"},
            { id = "j_runner"},
            { id = "j_scary_face"},
            { id = "j_scholar"},
            { id = "j_seance"},
            { id = "j_seeing_double"},
            { id = "j_selzer"},
            { id = "j_shoot_the_moon"},
            { id = "j_shortcut"},
            { id = "j_sixth_sense"},
            { id = "j_sly"},
            { id = "j_smeared"},
            { id = "j_smiley"},
            { id = "j_sock_and_buskin"},
            { id = "j_splash"},
            { id = "j_square"},
            { id = "j_steel_joker"},
            { id = "j_stone"},
            { id = "j_superposition"},
            { id = "j_ticket"},
            { id = "j_trading"},
            { id = "j_tribe"},
            { id = "j_triboulet"},
            { id = "j_trio"},
            { id = "j_trousers"},
            { id = "j_vampire"},
            { id = "j_walkie_talkie"},
            { id = "j_wee"},
            { id = "j_wily"},
            { id = "j_wrathful_joker"},
            { id = "j_yorick"},
            { id = "j_zany"},
            { id = "j_warehouse_librarian" },
            { id = "j_warehouse_bartender" },
            { id = "c_warehouse_i_hanged_man"},
            { id = "c_warehouse_i_sun"},
            { id = "c_warehouse_i_moon"},
            { id = "c_warehouse_i_stars"},
            { id = "c_warehouse_i_world"},
            { id = "c_warehouse_i_magician"},
            { id = "c_warehouse_i_justice"},
            { id = "c_warehouse_i_heirophant"},
            { id = "c_warehouse_hyperdrive"},
            { id = "c_sun"},
            { id = "c_strength"},
            { id = "c_star"},
            { id = "c_moon"},
            { id = "c_chariot"},
            { id = "c_death"},
            { id = "c_magician"},
            { id = "c_lovers"},
            { id = "c_justice"},
            { id = "c_heirophant"},
            { id = "c_empress"},
            { id = "c_devil"},
            { id = "c_hanged_man"},
            { id = "c_tower"},
            { id = "c_world"},
            { id = "c_aura"},
            { id = "c_cryptid"},
            { id = "c_deja_vu"},
            { id = "c_familiar"},
            { id = "c_grim"},
            { id = "c_immolate"},
            { id = "c_incantation"},
            { id = "c_medium"},
            { id = "c_ouija"},
            { id = "c_sigil"},
            { id = "c_talisman"},
            { id = "c_trance"},
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
        G.GAME.win_ante = 10
    end
}

local sel_blind = G.FUNCS.select_blind

G.FUNCS.select_blind = function(...)
    return sel_blind(...)
end

local play_hl = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    if G.GAME.modifiers.no_cards then
        G.hand:parse_highlighted()
    end
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