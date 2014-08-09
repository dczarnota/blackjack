class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  isPlayable: true

  hit: ->
    if !@isPlayable
      return

    @add(@deck.pop()).last()
    #if score > 21, then stand (because he got so busted)
    if @getValid() is -1
      @trigger 'bust'
      @isPlayable = false

  stand: ->
    # trigger stand event which will finish the player's turn
    @trigger 'stand'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  revealHand: ->
    #iterate thru each card
    @forEach (card) ->
      if !card.get 'revealed' then card.flip()
      #check if current card is revealed
      #if not, then reveal it

  getValid: ->
    #get the highest legal score possible, if there is none return -1
    score = -1

    if(@scores()[0] <= 21)
      score = @scores()[0]
    if(@scores()[1] and @scores()[1] <= 21)
      if(@scores()[1] > score)
        score = @scores()[1]

    return score
