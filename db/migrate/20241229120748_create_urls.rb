class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url
      t.string :api_token

      t.timestamps
    end
    add_index :urls, :short_url, unique: true
    add_index :urls, :api_token, unique: true
  end
end
