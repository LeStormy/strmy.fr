class UrlsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:api_create]
  def create
    target = params.require(:url).permit(:target)[:target].downcase
    url = Url.new(target: target)
    code = generate_short_string(4)
    while Url.find_by(code: code).present?
      code = generate_short_string(4)
    end

    url.code = code
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

  def api_create
    return unless bearer_token == Rails.application.credentials.dig(:api_token)
    target = params.permit(:target)[:target].downcase
    url = Url.new(target: target)
    code = generate_short_string(4)
    while Url.find_by(code: code).present?
      code = generate_short_string(4)
    end

    url.code = code
    url.save!
    
    render json: url.as_json
  end

  private

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"] # <= env
    header.gsub(pattern, '') if header && header.match(pattern)
  end

  def url_params
    params.require(:url).permit(:target)
  end

  def generate_short_string(length)
    characters = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    (0...length).map { characters.sample }.join
  end
end
