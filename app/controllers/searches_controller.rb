class SearchesController < ApplicationController
  get "/search" do
    # todo validation for face_cards ie scryfall#id="7f95145a-41a1-478e-bf8a-ea8838d6f9b1"
    # @cards = scryfall.search(params[:q])
    @query = params[:q]
    @cards = scryfall.search(@query)
    haml :'/searches/index'
  end 
end 