require 'Game.bet_sizing'

describe('Game.bet_sizing class', function()

  it('should create bet sizes correctly', function()

    local bet_sizes = {{1}, {1}, {1}}

    local bet_sizing = BetSizing(bet_sizes)

    local node = {}

    node.current_player = 1
    node.bets = {200, 200}

    local possible_bets = bet_sizing:get_possible_bets(node)

    assert.are.equal(possible_bets[1][1], 600)
    assert.are.equal(possible_bets[2][1], 20000)

  end)
end)

