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
		['j_diet_cola']=true,
		['j_gros_michel']=true,
		['j_ice_cream']=true,
		['j_turtle_bean']=true,
		['j_popcorn']=true,
		['j_ramen']=true,
		['j_flower_pot']=true,
		['j_mr_bones']=true
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
	local last_joker = nil
	if context.blueprint and context.joker_main then
	    -- only eat blueprint, bro got too close
	    if context.blueprint_card.config.center_key == "j_blueprint" then
		last_joker = context.blueprint_card
	    end
	end
	-- on round start check the jokers for food, stop on first foodie
	if context.setting_blind then 
	    if not context.blueprint and last_joker == nil then
		for i,value in ipairs(G.jokers.cards) do
		    if last_joker ~= nil then break end
		    if (card.ability.extra.jokers[value.config.center_key] or 
		    (value.config.center_key == "j_Gubby_gubby" and 
		    value.ability.extra.hand_size < card.ability.extra.hand_size))
		    and value.locked == nil then
			value.locked = true
			last_joker = value 
		    end
		end
	    end
	end
	if last_joker ~= nil then 
	    G.E_MANAGER:add_event(Event({
		func = function()
		    play_sound('tarot1')
		    last_joker.T.r = -0.2
		    last_joker:juice_up(0.3, 0.4)
		    last_joker.states.drag.is = true
		    last_joker.children.center.pinch.x = true
		    -- This part destroys the card.
		    G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.3,
			blockable = false,
			func = function()
			    G.hand:change_size(card.ability.extra.hands)
			    play_sound('Gubby_yummers',pseudorandom('gubby')*3)   
			    if last_joker.config.center_key == "j_diet_cola"then
				if G.jokers.config.card_limit > #G.jokers.cards-1 then
				    G.E_MANAGER:add_event(Event({
					func = function()
					    SMODS.add_card({
						set = 'Joker',
						area = G.jokers,
						key = "j_Gubby_gubby"
					    })
					    return true
					end
				    }))
				end
			    end
			    G.jokers:remove_card(last_joker)
			    last_joker:remove()
			    last_joker= nil
			    return true
			end
		    }))
		    return true
		end
	    }))
	    card.ability.extra.hand_size = card.ability.extra.hand_size + 1
	    return{
		message = "Yummers!",
		message_card = card
	    }
	end
    end
}
