
SMODS.Sticker {
	key = "blank",
	atlas = "warehouse_blank", pos = {x = 0, y = 0},
    badge_colour = HEX '000000',
    replace_base_card = true,
}

local card_stub = {
	get_id = function() return 0 end,
	is_suit = function() return false end,
	__stub = true
}

function get_next_card(this)
	local area = this.area
	local next_card = card_stub
	local found_self = false
	for i, card in ipairs(area.cards) do
		if found_self and
			not (this.highlighted and not card.highlighted)
		then
			next_card = card
			break
		end
		if card == this then
			found_self = true
		end
	end
	return next_card
end

local Card_get_id = Card.get_id
function Card:get_id()
	if self.ability.warehouse_blank then
		local next_card = get_next_card(self)
		if next_card ~= nil then
			return next_card:get_id()
		end
	end
	return Card_get_id(self)
end

local Card_is_suit = Card.is_suit
function Card:is_suit(...)
	if self.ability.warehouse_blank then
		local next_card = get_next_card(self)
		if next_card ~= nil then
			return next_card:is_suit(...)
		end
	end
	return Card_is_suit(self, ...)
end

local SMODS_has_no_rank = SMODS.has_no_rank
function SMODS.has_no_rank(card)
	if card.ability.warehouse_blank then
		local next_card = get_next_card(card)
		if next_card ~= nil and not next_card.__stub then
			return SMODS.has_no_rank(next_card)
		end
		return true
	end
	return SMODS_has_no_rank(card)
end

local SMODS_has_any_suit = SMODS.has_any_suit
function SMODS.has_any_suit(card)
	if card.ability.warehouse_blank then
		local next_card = get_next_card(card)
		if next_card ~= nil and not next_card.__stub then
			return SMODS.has_any_suit(next_card)
		end
	end
	return SMODS_has_any_suit(card)
end

local SMODS_has_no_suit = SMODS.has_no_suit
function SMODS.has_no_suit(card)
	if card.ability.warehouse_blank then
		local next_card = get_next_card(card)
		if next_card ~= nil and not next_card.__stub then
			return SMODS.has_no_suit(next_card)
		end
		return true
	end
	return SMODS_has_no_suit(card)
end

local CardArea_shuffle = CardArea.shuffle
function CardArea:shuffle(...)
	CardArea_shuffle(self, ...)
	if self == G.hand then self:parse_highlighted() end
end

local CardArea_sort = CardArea.sort
function CardArea:sort(...)
	CardArea_sort(self, ...)
	if self == G.hand then self:parse_highlighted() end
end

local Node_stop_drag = Node.stop_drag
function Node:stop_drag(...)
	Node_stop_drag(self, ...)
	if self.area and self.area == G.hand then self.area:parse_highlighted() end
end

local front_func = SMODS.DrawSteps.front.func
SMODS.DrawSteps.front.func = function(self, layer)
	if self.ability.warehouse_blank then return end
	return front_func(self, layer)
end

local Card_get_nominal = Card.get_nominal
function Card:get_nominal(mod)
	local res = Card_get_nominal(self, mod)
	if self.ability.warehouse_blank then
		res = math.abs(res) * -100000
	end
	return res
end

local Card_should_hide_front = Card.should_hide_front
function Card:should_hide_front()
    if self.ability.warehouse_blank then return true end
    return Card_should_hide_front(self)
end