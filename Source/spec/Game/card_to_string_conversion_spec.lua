local card_to_string = require 'Game.card_to_string_conversion'
local arguments = require 'Settings.arguments'

describe('Game.card_to_string_conversion class', function()

  it('should conver card to strings correctly', function()

    -- Validate card_to_string

    assert(card_to_string:card_to_string(1) == '2c', card_to_string:card_to_string(1))
    assert(card_to_string:card_to_string(2) == '2d', card_to_string:card_to_string(2))
    assert(card_to_string:card_to_string(3) == '2h', card_to_string:card_to_string(3))
    assert(card_to_string:card_to_string(4) == '2s', card_to_string:card_to_string(4))

    assert(card_to_string:card_to_string(49) == 'Ac', card_to_string:card_to_string(49))
    assert(card_to_string:card_to_string(50) == 'Ad', card_to_string:card_to_string(50))
    assert(card_to_string:card_to_string(51) == 'Ah', card_to_string:card_to_string(51))
    assert(card_to_string:card_to_string(52) == 'As', card_to_string:card_to_string(52))

    -- assert throw exception

    local status, _ = pcall(function() card_to_string:card_to_string(0) end)

    assert(not status, "It should throw an error message")

    local status, _ = pcall(function() card_to_string:card_to_string(53) end)

    assert(not status, "It should throw an error message")

    local status, _ = pcall(function() card_to_string:card_to_string(-1) end)

    assert(not status, "It should throw an error message")

    local status, _ = pcall(function() card_to_string:card_to_string(nil) end)

    assert(not status, "It should throw an error message")

    local status, _ = pcall(function() card_to_string:card_to_string('randomtext') end)

    assert(not status, "It should throw an error message")


    -- Validate cards_to_string
    assert(card_to_string:cards_to_string(torch.Tensor({1, 49})) == '2cAc', card_to_string:cards_to_string(torch.Tensor({1, 49})))
    assert(card_to_string:cards_to_string(torch.Tensor({52, 4})) == 'As2s', card_to_string:cards_to_string(torch.Tensor({52, 4})))


    -- Validate card_to_suit
    assert(card_to_string:card_to_suit(1) == 1 and card_to_string.suit_table[1] == 'c')
    assert(card_to_string:card_to_suit(2) == 2 and card_to_string.suit_table[2] == 'd')
    assert(card_to_string:card_to_suit(3) == 3 and card_to_string.suit_table[3] == 'h')
    assert(card_to_string:card_to_suit(4) == 4 and card_to_string.suit_table[4] == 's')

    -- Validate card_to_rank
    assert(card_to_string:card_to_rank(1) == 1 and card_to_string.rank_table[1] == '2')
    assert(card_to_string:card_to_rank(2) == 1 and card_to_string.rank_table[1] == '2')
    assert(card_to_string:card_to_rank(3) == 1 and card_to_string.rank_table[1] == '2')
    assert(card_to_string:card_to_rank(4) == 1 and card_to_string.rank_table[1] == '2')

    -- TODO increment card_to_rank tests

    -- Validate string_to_card and card_to_string
    assert(card_to_string:string_to_card('As') == 52, "Different values " .. card_to_string:string_to_card('As') .. " _ " .. 1)
    assert(card_to_string:card_to_string(52) == 'As', "Different values " .. card_to_string:card_to_string(1) .. " _ " .. 1)


    -- Validate string_to_board
    assert(arguments.Tensor.eq(card_to_string:string_to_board(''), arguments.Tensor{}))

    assert(torch.all(arguments.Tensor.eq(card_to_string:string_to_board('As'), arguments.Tensor{52})))
    assert(torch.all(arguments.Tensor.eq(card_to_string:string_to_board('AsAc'), arguments.Tensor{52, 49})))

    assert(torch.all(arguments.Tensor.eq(card_to_string:string_to_board('AsAcAh'), arguments.Tensor{52, 49, 51})))
    assert(torch.all(arguments.Tensor.eq(card_to_string:string_to_board('AhAsAc'), arguments.Tensor{51, 52, 49})))
    assert(torch.all(arguments.Tensor.eq(card_to_string:string_to_board('AhAsAc2s2h'), arguments.Tensor{51, 52, 49, 4, 3})))
    assert(torch.all(arguments.Tensor.eq(card_to_string:string_to_board('AsAcAdAhKs'), arguments.Tensor{52, 49, 50, 51, 48})), tostring(card_to_string:string_to_board('AsAcAdAhKs')))

  end)
end)
