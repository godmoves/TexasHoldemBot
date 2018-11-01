local arguments = require 'Settings.arguments'
local game_settings = require 'Settings.game_settings'

-- Set a specific seed
torch.manualSeed(123)

describe("DataGeneration.random_card_generator class", function()
  describe("should generate a range given a specific board", function()

    it("should generate same randomly cards with a specific seed", function()

      local card_generator = require 'DataGeneration.random_card_generator'

      -- Generate a set of random cards
      -- 1 Random card

      local cards = card_generator:generate_cards(1)

      assert(torch.all(arguments.Tensor.eq(cards, arguments.Tensor{7})), tostring(cards))


      -- 3 Random card
      cards = card_generator:generate_cards(3)

      assert(torch.all(arguments.Tensor.eq(cards, arguments.Tensor{2, 47, 51})), tostring(cards))

      -- 5 Random card
      cards = card_generator:generate_cards(5)

      assert(torch.all(arguments.Tensor.eq(cards, arguments.Tensor{1, 51, 23, 14, 16})), tostring(cards))

      cards = card_generator:generate_cards(5)

      assert(torch.all(arguments.Tensor.eq(cards, arguments.Tensor{3, 12, 18, 51, 46})), tostring(cards))

    end)

    it("should return error on error board", function()

      -- 0 Random card
      local status, _ = pcall(function() card_generator:generate_cards(0) end)

      assert(not status, 'It should throw an error message')

      -- request 53 card
      local status, _ = pcall(function() card_generator:generate_cards(game_settings.card_count + 1) end)

      assert(not status, 'It should throw an error message')

      -- request nil
      local status, _ = pcall(function() card_generator:generate_cards(nil) end)

      assert(not status, 'It should throw an error message')

      -- request 'string'
      local status, _ = pcall(function() card_generator:generate_cards('string val') end)

      assert(not status, 'It should throw an error message')

    end)
  end)
end)
