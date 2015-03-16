class ChangeColumnDefaultInDeals < ActiveRecord::Migration
  def change
    change_column_default :deals, :monday, false
    change_column_default :deals, :tuesday, false
    change_column_default :deals, :wednesday, false
    change_column_default :deals, :thursday, false
    change_column_default :deals, :friday, false
    change_column_default :deals, :saturday, false
    change_column_default :deals, :sunday, false
  end
end
