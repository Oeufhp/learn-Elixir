defmodule Cards do

  @moduledoc """
   Provide methods for creating and handling the deck of cards

  """


	@doc """
		Return a list of string that represent the cards in the deck
	"""
	def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    cards = for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

    List.flatten(cards)

  end

  @spec shuffle(any) :: [any]
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

	@doc """
		Determins whether the card is in a deck or not

		##Example
		iex> deck = Cards.create_deck
		iex> Cards.contains?(deck, "Ace of Hearts")
		true
	"""

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

	@doc """
		Divides a deck into a hand and the remainder of the deck.
		The `num_card` argument indicates how many cards should be in the hand.
	
		##Example
			iex> deck = Cards.create_deck
			iex> {hand, deck} = Cards.deal(deck, 1)
			iex> hand
			["Ace of Spades"]

	"""

  def deal(deck, num_card) do
    Enum.split(deck, num_card) #{*hands, *remain_in_decks }
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # {status, binary} = File.read(filename)

    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist."
    end
  end

  def create_hand(num_card) do

     Cards.create_deck |> Cards.shuffle |> Cards.deal(num_card)
  end

end
