class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.integer :crn
    	t.string :course_number
    	t.string :course_name
      	t.timestamps
    end
  end
end
