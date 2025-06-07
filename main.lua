SMODS.Atlas {
    key = "Gubbyatlas",
    px = 71,
    py = 95,
    path = "gubby.png"
}

SMODS.Sound{
    key = 'yummers',
    path = 'yummers.ogg'
}

gubbytext = {
    name = "Gubby",
    text = {'When round starts consume',
	    'an edible joker and gain',
	    'Permanent {C:attention}+#1# hand size{}',
	    '{C:inactive}(Currently {C:attention}#2# Hand size{}{C:inactive})'
    }
}

SMODS.Joker {
    key = "gubby",
    atlas = "Gubbyatlas",
    loc_txt = gubbytext,
    unlocked = true,
    discovered = true,
    config = {extra = {hands = 1,hand_size = 0}},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands,card.ability.extra.hand_size } }
    end,
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    pos = {x=0,y=0},
    calculate = function(self,card,context)
	if context.	
    end
}
