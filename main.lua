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
	    'an {V:1}edible{} joker and gain',
	    'Permanent {C:attention}+#1# hand size{}',
	    '{C:inactive}(Currently {C:attention}+#2#{}{C:inactive} Hand size)'
    }
}

SMODS.Joker {
    key = "gubby",
    atlas = "Gubbyatlas",
    loc_txt = gubbytext,
    unlocked = true,
    discovered = true,
    config = {
	extra = {
	    hands = 1,
	    hand_size = 0,
	    jokers ={
		['j_gros_michel']=true,
		['j_ice_cream']=true,
		['j_turtle_bean']=true,
		['j_popcorn']=true,
		['j_ramen']=true,
		['j_mr_bones']=true,
		['j_flower_pot']=true,
		['j_chicot']=true
	    }
	}
    },
    loc_vars = function(self, info_queue, card)
	info_queue[#info_queue+1] = gubbytext
	return{ 
	    vars = {
		card.ability.extra.hands,
		card.ability.extra.hand_size,
		card.ability.extra.jokers,
		colours = {
		    HEX("ff7f7f")	
		}
	    }
	}
    end,
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    pos = {x=0,y=0},
    calculate = function(self,card,context)
	if context.setting_blind then
	    for i,value in ipairs(G.jokers.cards) do
	    	if card.ability.extra.jokers[value.config.center_key] then
		    G.E_MANAGER:add_event(Event({
			
		    }))
	    	end
	    end
	end	
    end
}
