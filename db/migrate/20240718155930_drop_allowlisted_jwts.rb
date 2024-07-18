class DropAllowlistedJwts < ActiveRecord::Migration[7.1]
  def change
    drop_table :allowlisted_jwts
  end
end
