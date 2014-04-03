class UndoColumnRename < ActiveRecord::Migration
  def up
    rename_column :foodevents, :e_from, :from
    rename_column :foodevents, :e_subject, :subject
    rename_column :foodevents, :e_date, :date
    rename_column :foodevents, :e_time, :time
    rename_column :foodevents, :e_body, :body
  end
    
  def down
  end
end
