#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #set listener on player hand so we can deal with stands
    @get("playerHand").on "stand",((collection) ->
      playerScore = @get("playerHand").getValid()
      if playerScore isnt -1
        @challenge()
      else
        @set 'gameResult', "You lost big time."
    ), this
    @set 'gameResult', ""


  challenge: ->
    @get('dealerHand').revealHand()

    while @get("dealerHand").getValid() < 17 and @get("dealerHand").getValid() isnt -1
      @get("dealerHand").hit()

    dealerScore = @get("dealerHand").getValid()

    if dealerScore isnt -1
      if dealerScore >= @get("playerHand").getValid()
        @set 'gameResult', "You lost big time."
      else
        @set 'gameResult', "You won, pat yourself on the back!"
    else
      @set 'gameResult', "You won, pat yourself on the back!"
