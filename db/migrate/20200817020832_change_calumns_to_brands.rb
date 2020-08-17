class ChangeCalumnsToBrands < ActiveRecord::Migration[6.0]
  def change
    change_column_null :brands, :name, true
  end
end
