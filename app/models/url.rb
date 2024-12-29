# frozen_string_literal: true

class Url < ApplicationRecord
  before_create :generate_short_url
  before_validation :generate_api_token, on: :create
  
  validates :long_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :api_token, presence: true, uniqueness: true, on: :create

  private

  def generate_api_token
    self.api_token ||= SecureRandom.hex(16)
  end

  def generate_short_url
    self.short_url = SecureRandom.hex(4)
  end
end
