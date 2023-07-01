class UrlsController < ApplicationController
  def create
    target = params.require(:url).permit(:target)[:target].downcase
    url = Url.new(target: target)
    url.code = generate_short_string(4)
    url.save!

    redirect_to url_path(url.code)
  end

  def show 
    @url = Url.find_by(code: params[:id])
  end

  def redirect
    url = Url.find_by(code: params[:code])
    Use.create!(url: url)
    redirect_to url&.target, allow_other_host: true
  end

  private

  def url_params
    params.require(:url).permit(:target)
  end

  def generate_short_string(length)
    characters = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    (0...length).map { characters.sample }.join
  end
end
