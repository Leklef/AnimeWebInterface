class Anime

  attr_accessor :title, :cover_image, :synopsis

  def initialize(params)
    @synopsis = params[:synopsis]
    @title = params[:title]
    @cover_image = params[:cover_image]
  end

end