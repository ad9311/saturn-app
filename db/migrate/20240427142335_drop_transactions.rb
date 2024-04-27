class DropTransactions < ActiveRecord::Migration[7.1]
  def change
    drop_table :transactions
  end
end
