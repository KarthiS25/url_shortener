# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :authenticate_api_token, only: [:create], if: :api_request?

  def index
    urls = Url.all.select(:id, :short_url)

    render json: { data: urls, message: "Url list" }, status: :created
  end

  def create
    url = Url.new(url_params)
    if url.save
      render json: { short_url: url.short_url, long_url: url.long_url }, status: :created
    else
      render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    url = Url.find_by(short_url: params[:short_url])
    if url
      redirect_to url.long_url, status: :moved_permanently
    else
      render json: { error: 'Shortened URL not found' }, status: :not_found
    end
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end

  def authenticate_api_token
    token = request.headers['Authorization']&.split(' ')&.last
    render json: { error: 'Unauthorized' }, status: :unauthorized unless Url.exists?(api_token: token)
  end

  def api_request?
    request.format.json? || request.format.xml?
  end
end
