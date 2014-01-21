class Course < ActiveRecord::Base
	has_many :enrollments, dependent: :destroy
  	has_many :users, through: :enrollments

	validates :crn, presence:true
	validates :course_number, presence:true
	validates :course_name, presence:true
end
