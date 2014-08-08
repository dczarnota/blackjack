#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #set listener on player hand so we can deal with stands
    @get("playerHand").on "stand",((collection) ->
      #do something
      console.log("player has stood")
      console.log (@get("playerHand").scores())
    ), this

  challenge: ->
    #flip all cards in dealer's hand
    #if current score < 17, then hit()
      #if score after hit is > 21, then bust() and player wins
    #if current score <= 21 and current score > player score, then player loses
    #else player wins
    #get dealer's current score
    @get("dealerHand").scores()
