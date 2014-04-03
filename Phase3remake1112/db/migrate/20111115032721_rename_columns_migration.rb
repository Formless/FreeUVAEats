class RenameColumnsMigration < ActiveRecord::Migration
  def change
    change_table :foodevents do |t|
      t.rename :from, :e_from
      t.rename :subject, :e_subject
      t.rename :date, :e_date
      t.rename :time, :e_time
      t.rename :body, :e_body
    end
  end
end
