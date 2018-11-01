require 'Game.bet_sizing'
local constants = require 'Settings.constants'
local arguments = require 'Settings.arguments'
local card_to_string = require 'Game.card_to_string_conversion'

describe('Game.bet_sizing class', function()

  it('should create bet sizes correctly', function()

    -- Define stack of size 1000
    arguments.stack = 1000
    arguments.ante = 100

    -- only 2x pot size
    arguments.bet_sizing = {{2}, {2}, {2}}

    local betSizing = BetSizing(arguments.bet_sizing)

    node = {}
    node.current_player = 1
    node.bets = arguments.Tensor{100, 100}
    node.num_bets = 1

    bets = betSizing:get_possible_bets(node)

    assert(torch.all(arguments.Tensor.eq(bets, arguments.Tensor{{500, 100}, {1000, 100}})), tostring(bets))

    -- different pot sizes
    arguments.bet_sizing = {{0.5, 1, 2, 5, 10}, {1}, {1}}

    betSizing = BetSizing(arguments.bet_sizing)

    node = {}
    node.current_player = 1
    node.num_bets = 0
    node.bets = arguments.Tensor{0, 100}

    bets = betSizing:get_possible_bets(node)

    assert(torch.all(arguments.Tensor.eq(bets, arguments.Tensor{{200, 100}, {300, 100}, {500, 100}, {1000, 100}})), tostring(bets))

    -- current player == 2
    arguments.bet_sizing = {{0.5, 1, 2, 5, 10}, {1}, {1}}

    betSizing = BetSizing(arguments.bet_sizing)

    node = {}
    node.current_player = 2
    node.bets = arguments.Tensor{100, 100}
    node.num_bets = 0

    bets = betSizing:get_possible_bets(node)

    assert(torch.all(arguments.Tensor.eq(bets, arguments.Tensor{{100, 200}, {100, 300}, {100, 500}, {100, 1000}})), tostring(bets))

    -- without ante
    arguments.ante = 0

    arguments.bet_sizing = {{0.5, 1, 2, 5, 10}, {1}, {1}}

    betSizing = BetSizing(arguments.bet_sizing)

    node = {}
    node.current_player = 2
    node.bets = arguments.Tensor{3, 0}
    node.num_bets = 0

    bets = betSizing:get_possible_bets(node)

    assert(torch.all(arguments.Tensor.eq(bets, arguments.Tensor{{3, 6}, {3, 9}, {3, 15}, {3, 33}, {3, 63}, {3, 1000}})), tostring(bets))

    -- error: current player
    node = {}
    node.current_player = 0
    node.bets = arguments.Tensor{0, 0}
    node.num_bets = 0

    local status, _ = pcall(function() betSizing:get_possible_bets(node) end)

    assert(not status, "It should throw an error message = Wrong player for bet size computation")

  end)
end)
