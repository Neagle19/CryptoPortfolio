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
  @all_symbols = []
    for x in @coins
      @all_symbols << x['symbol']
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
