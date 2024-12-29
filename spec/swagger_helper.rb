# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          BearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT
          }
        }
      },
      security: [
        { BearerAuth: [] }
      ]
    }
  }

  config.openapi_format = :yaml
end