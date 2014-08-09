#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #set listener on player hand so we can deal with stands
    @get("playerHand").on "stand",((collection) ->
      @challenge()
    ), this

  challenge: ->
    #flip all cards in dealer's hand
    @get('dealerHand').revealHand()
    #while dealer's current score < 17, then hit()
    playerScore = @get('playerHand').scores()

    while @get('dealerHand').scores()[0] < 17 and (@get('dealerHand').scores()[1] < 17 or true)
      @get('dealerHand').hit();


    if @get('dealerHand').scores()[0] <= 21 and (@get('dealerHand').scores()[1] < 17 or true) then console.log "You're lost! You're bad at life." else console.log "you win"
