require 'net/http'
require 'json'

class AnimeController < ApplicationController

  def index
    if params[:query].present?
      search_anime(params[:query])
    else
      if params[:page].present?
        get_anime(params[:page][:number])
      else
        get_anime()
      end
    end
    render "anime/index"
  end

  private

  def get_anime(page = 1)
    base_url = "https://anime-data-storage.herokuapp.com/animes?page%5Bnumber%5D=#{page}\\u0026page%5Bsize%5D=30"
    uri = URI(base_url)
    response = Net::HTTP.get(uri)
    json_data = JSON.parse(response)
    @animes = []
    json_data['data'].each do |item|
      @animes << Anime.new(synopsis: item['attributes']['synopsis'],
                   title: item['attributes']['title'],
                   cover_image: item['attributes']['cover-image'])
    end
  end

  def search_anime(query)
    base_url = "https://anime-data-storage.herokuapp.com/animes?query=#{query}"
    uri = URI(base_url)
    response = Net::HTTP.get(uri)
    json_data = JSON.parse(response)
    @animes = []
    json_data['data'].each do |item|
      @animes << Anime.new(synopsis: item['attributes']['synopsis'],
                           title: item['attributes']['title'],
                           cover_image: item['attributes']['cover-image'])
    end
  end

end
