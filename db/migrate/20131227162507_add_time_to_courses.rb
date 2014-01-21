class AddTimeToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :time, :string
  end
end
