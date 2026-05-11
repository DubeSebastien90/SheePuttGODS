global.level_data = [
    [
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~...m.m...~~~~~~~",
        "~~~~~.....m.....~~~~~~",
        "~~~~~....m.m....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~~eeeeeeeee~~~~~~~",
        "~~~~~~~eeeeeee~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
    [
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~...m.m...~~~~~~~",
        "~~~~~.....m.....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~....eee....~~~~~~",
        "~~~~~....eee....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~.....m.....~~~~~~",
        "~~~~~~...m.m...~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
    [
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~...m.m...~~~~~~~",
        "~~~~~...m.m.m...~~~~~~",
        "~~~~~....m.m....~~~~~~",
        "~~~~~~~~........~~~~~~",
        "~~~~~..~~~~~~...~~~~~~",
        "~~~~~.......~~~~~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~~eeeeeeeee~~~~~~~",
        "~~~~~~~eeeeeee~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
       [
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~...m.m...~~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~~.........~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~www~~~~~~~~~~",
        "~~~~~~~~~www~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
        [
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~.....~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~~..m.m..~~~~~~~~",
        "~~~~~~~~..m..~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~..~~~~~~~~~~~",
        "~~~~~~~~....~~~~~~~~~~",
        "~~~~~~~~....~~~~~~~~~~",
        "~~~~~~~~~..~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~ee~~~~~~~~",
        "~~~~~~~~~~~eeee~~~~~~~",
        "~~~~~~~~~~~eeee~~~~~~~",
        "~~~~~~~~~~~~ee~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
		"~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
	[
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~...mmm...~~~~~~~",
        "~~~~~.....m.....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...b.b.b...~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~..b.....b..~~~~~~",
        "~~~~~.....b.....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~~eeeeeeeee~~~~~~~",
        "~~~~~~~eeeeeee~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
    [
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~...b.......~~~~~",
    "~~~~~~..b.....ee.~~~~~",
    "~~~~~~.b......ee.~~~~~",
    "~~~~~~b..........~~~~~",
    "~~~~~~....~~~~~~~~~~~~",
    "~~~~~~....~~~~~~~~~~~~",
    "~~~~~~....~~~~~~~~~~~~",
    "~~~~~~....~~~~~~~~~~~~",
    "~~~~~~.mm.~~~~~~~~~~~~",
    "~~~~~~.mm.~~~~~~~~~~~~",
    "~~~~~~....~~~~~~~~~~~~",
    "~~~~~~....~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~",
],
	[
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~.m.m.m.m.~~~~~~~",
        "~~~~~.m.m.m.m.m.~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~..bb...bb..~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...bbbbb...~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~beeeeeeeeeb~~~~~~",
        "~~~~~~beeeeeeeb~~~~~~~",
        "~~~~~~~bbbbbbb~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
	[
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~.........~~~~~~~",
        "~~~~~.....m.....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~.....v.....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~~eeeeeeeee~~~~~~~",
        "~~~~~~~eeeeeee~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],	
	[
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~.......~~~~~~~~",
        "~~~~~~...m.m...~~~~~~~",
        "~~~~~.....m.....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~b.........b~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~....v.v....~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~...........~~~~~~",
        "~~~~~~eeeeeeeee~~~~~~~",
        "~~~~~~~eeeeeee~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~~~~~~~",
    ],
];

global.conditions = [
	{
		level_title: "From edge to edge",
		unlocked: true,
		muttons_for_win: 3,
		muttons_total: 5,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 6 stomps",
			nbStomps: 6
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 15 seconds",
			nbSeconds: 15
		}
	},
	{
		level_title: "Gather up!",
		unlocked: false,
		muttons_for_win: 3,
		muttons_total: 6,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 6 stomps",
			nbStomps: 6
		},
		third_star: 
		{
			collected: false,
			description: "Stomp 3 of your sheeps",
			nbSeconds: 15
		}
	},
	{
		level_title: "Hop hop hop",
		unlocked: false,
		muttons_for_win: 4,
		muttons_total: 7,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 6 stomps",
			nbStomps: 6
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 15 seconds",
			nbSeconds: 15
		}
	},
	{
		level_title: "Can you aim?",
		unlocked: false,
		muttons_for_win: 1,
		muttons_total: 2,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 2 stomps",
			nbStomps: 2
		},
		third_star: 
		{
			collected: false,
			description: "Put the two sheeps in the same tile",
			nbSeconds: 15
		}
	},
	{
		level_title: "Archipelago",
		unlocked: false,
		muttons_for_win: 1,
		muttons_total: 3,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 3 stomps",
			nbStomps: 3
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 10 seconds",
			nbSeconds: 10
		}
	},
	{
		level_title: "Boing boing!",
		unlocked: false,
		muttons_for_win: 2,
		muttons_total: 4,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 3 stomps",
			nbStomps: 3
		},
		third_star: 
		{
			collected: false,
			description: "Complete the level without bouncing once",
			nbSeconds: 10
		}
	},
    {
		level_title: "Par 2",
		unlocked: false,
		muttons_for_win: 1,
		muttons_total: 4,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 2 stomps",
			nbStomps: 2
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 12 seconds",
			nbSeconds: 12
		}
	},
	{
		level_title: "Bouncy castle",
		unlocked: false,
		muttons_for_win: 5,
		muttons_total: 9,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 7 stomps",
			nbStomps: 7
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 20 seconds",
			nbSeconds: 20
		}
	},
	{
		level_title: "Oh look, a new friend!",
		unlocked: false,
		muttons_for_win: 1,
		muttons_total: 1,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in only 1 stomp",
			nbStomps: 1
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 5 seconds",
			nbSeconds: 5
		}
	},
	{
		level_title: "Please don't eat me!",
		unlocked: false,
		muttons_for_win: 2,
		muttons_total: 3,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in max 3 stomps",
			nbStomps: 3
		},
		third_star: 
		{
			collected: false,
			description: "Stomp every wolves",
			nbSeconds: 5
		},
	}
]