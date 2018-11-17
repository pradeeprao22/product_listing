class ShortUrlsController < ApplicationController

  before_action :find_url, only: [:show, :short]
  skip_before_action :verify_authenticity_token

  def index
    @url = ShortUrl.new
  end

  def show
    redirect_to @url.sanitize_url
  end

  def create
    @url = ShortUrl.new
    @url.original_url = params[:original_url]
    @url.sanitize
    if @url.new_url
      if @url.save
        redirect_to short_path(@url.shorts_url)
      else
        flash[:error] = "Check the error below:"
        render 'index'
      end
    else
      flash[:notice] = "A short link for this Url is already in our database"
      redirect_to short_path(@url.find_duplicate.shorts_url)
    end
  end

  def short
    @url = ShortUrl.find_by_short_url(params[:shorts_url])
    host = request.host_with_port
    @original_url = @url.sanitize_url
    @shorts_url = host + '/' + @url.shorts_url
  end

  def fetch_original_url
    fetch_url = ShortUrl.find_by_shorts_url(params[:shorts_url])
    redirect_to fetch_url.sanitize_url
  end

  private
  def find_url
    @url = ShortUrl.find_by_shorts_url(params[:shorts_url])
  end

  def url_params
  params.require(:url).permit(:original_url)
  end

end
