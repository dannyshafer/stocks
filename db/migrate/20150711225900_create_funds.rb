class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :morningstar_rating
      t.string :name
      t.string :category
      t.string :description
      t.string :price
      t.string :expense_ratio
      t.string :div_yield
      t.string :ytd_return
      t.string :five_yr_return
      t.string :total_assets
      t.string :three_yr_beta
      t.string :rank_in_category
      t.string :percent_rank_in_category

      t.timestamps
    end
  end
end
