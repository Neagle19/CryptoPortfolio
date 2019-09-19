class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = 'https://api.coinmarketcap.com/v1/ticker/'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @coins = JSON.parse(@response)
  end

  def about
  end

  def lookup
  require 'net/http'
  require 'json'
  @url = 'https://api.coinmarketcap.com/v1/ticker/'
  @uri = URI(@url)
  @response = Net::HTTP.get(@uri)
  @coins = JSON.parse(@response)
  @symbol = params[:sym]
    if @symbol
      @symbol = @symbol.upcase
      if @symbol == "AMB"
        @symbol = "I suggest you revise your investment strategy"
      end
      for coin in @coins
        if @symbol == "#{coin['symbol']}"
          @symbol = "#{coin['name']} - Current Price: $#{coin['price_usd']}"
        # elsif @symbol != "#{coin['symbol']}"
        #   @symbol = "Sorry, could not retrieve records for your search. Please try again."
        end
      end
    end
    # @list_of_symbols.each do |sym|
    #   if @symbol
    #     @symbol.upcase
    #     @coins.each do |coin|
    if @symbol == ""
      @symbol = "Error: Please enter a valid cryptocurrency symbol such as 'BTC', 'ETH' etc."
    end
    if @symbol != nil && @symbol.length > 5
      @symbol = "Error: Please enter a valid cryptocurrency symbol such as 'BTC', 'ETH' etc."
    end
  end
end

# <% @coins.each do |coin| %>
#    <% if coin["symbol"] == @symbol %>
#    <%= coin["name"] %>: $<%= coin["price_usd"] %>
#   <% end %>
# <% end %>
      # for coin in @coins
      #   if sym == coin["symbol"]
      #     puts "#{coin["name"]}: #{coin["price_usd"]}"
      #   end
      # end
#       <% @coins.each do |coin| %>
#   <% if coin["symbol"] == @symbol %>
#     <%= coin["name"] %>: $<%= coin["price_usd"] %>
#   <% end %>
# <% end %>
