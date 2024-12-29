# frozen_string_literal: true

class Api::V1::UrlsController < ApplicationController
  before_action :authenticate_api_token, except: [:create, :index], if: :api_request?

  def index
    urls = Url.all.select(:id, :short_url, :api_token)

    render json: { data: urls, message: "Url's list" }, status: :created
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      render json: { short_url: @url.short_url, long_url: @url.long_url, api_token: @url.api_token }, status: :created
    else
      render json: { errors: @url.errors.full_messages[0] }, status: :unprocessable_entity
    end
  end

  def show
    short_url = params[:short_url]
    url = Url.find_by(short_url: short_url)

    if url
      if api_request?
        render json: { long_url: url.long_url }, status: :ok
      else
        redirect_to url.long_url, allow_other_host: true
      end
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
