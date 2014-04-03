class CreateFoodevents < ActiveRecord::Migration
  def change
    create_table :foodevents do |t|
      t.string :e_from
      t.string :e_subject
      t.string :e_date
      t.string :e_time
      t.text :e_body

      t.timestamps
    end
  end
end
