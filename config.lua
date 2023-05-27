Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.OldQBCore = false    -- If you use an older QBCore version that uses the GetObject events instead of exports set this to true

Config.StartLocation = {x = 88.99, y = -222.36, z = 54.64}

Config.Reward = {	-- Minimum and maximum reward per bag delivered
    min = 200,
    max = 650
}

Config.Times = {
    ["wait"] = {	-- Time in seconds to wait between orders
        min = 15,
        max = 60
    }
}

Config.Chances = {
    ["get"] = 100,		-- Chance of getting the job when one comes in
    ["amount"] = 50		-- Chance of getting more than 1 bag and the chance of getting more than 2 bags if you get more than 1 bag
}

Config.Blips = {
    ["start"] = {
        label = "Food Delivery",
        sprite = 568,
        colour = 5,
        scale = 1.0
    },
    ["pickup"] = {
        sprite = 478,
        colour = 5,
        scale = 1.0
    },
    ["delivery"] = {
        label = "Customer",
        sprite = 280,
        colour = 5,
        scale = 1.0
    }
}

Config.Companies = {
    [1] = {
        label = "Bean Machine Coffee",						-- Name of the company
        item = "beanmachine-delivery",						-- Item given for deliveries
        coords = {x = -627.45, y = 239.05, z = 81.89},		-- Coords where to pickup orders
        society = {
            enable = false,						-- Enable society getting paid for deliveries (requires qb-bossmenu)
            account = "society_beanmachine",    -- The account the society needs to get paid in
            percent = 30						-- Percentage that gets paid to the society
        },
        job = {
            enable = false,			-- Enable checking if job is online to recieve order
            name = "beanmachine"	-- Name of the job that needs to be checked
        }
    },
    [2] = {
        label = "Burgershot",								-- Name of the company
        item = "burgershot-delivery",						-- Item given for deliveries
        coords = {x = -1183.48, y = -884.15, z = 13.74},	-- Coords where to pickup orders
        society = {
            enable = false,						-- Enable society getting paid for deliveries (requires qb-bossmenu)
            account = "society_burgershot",		-- The account the society needs to get paid in
            percent = 30						-- Percentage that gets paid to the society
        },
        job = {
            enable = false,			-- Enable checking if job is online to recieve order
            name = "burgershot"		-- Name of the job that needs to be checked
        }
    },
    [3] = {
        label = "the Taco Farmer",							-- Name of the company
        item = "tacofarmer-delivery",						-- Item given for deliveries
        coords = {x = 5.25, y = -1605.23, z = 29.38},		-- Coords where to pickup orders
        society = {
            enable = false,						-- Enable society getting paid for deliveries (requires qb-bossmenu)
            account = "society_tacofarmer",		-- The account the society needs to get paid in
            percent = 30						-- Percentage that gets paid to the society
        },
        job = {
            enable = false,			-- Enable checking if job is online to recieve order
            name = "tacofarmer"		-- Name of the job that needs to be checked
        }
    }
}