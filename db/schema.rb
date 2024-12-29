ActiveRecord::Schema[7.1].define(version: 2024_12_29_120748) do
  enable_extension "plpgsql"

  create_table "urls", force: :cascade do |t|
    t.string "long_url"
    t.string "short_url"
    t.string "api_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_token"], name: "index_urls_on_api_token", unique: true
    t.index ["short_url"], name: "index_urls_on_short_url", unique: true
  end

end
