# frozen_string_literal: true

require 'zombie_battleground/api/extensions/cards'
require 'zombie_battleground/api/extensions/decks'

module ZombieBattleground
  class Api
    ##
    #  API Extensions
    module Extensions
      include ZombieBattleground::Api::Extensions::Cards
      include ZombieBattleground::Api::Extensions::Decks
    end
  end
end
