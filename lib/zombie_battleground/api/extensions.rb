# frozen_string_literal: true

require 'zombie_battleground/api/extensions/cards'

module ZombieBattleground
  class Api
    ##
    #  API Extensions
    module Extensions
      include ZombieBattleground::Api::Extensions::Cards
    end
  end
end
