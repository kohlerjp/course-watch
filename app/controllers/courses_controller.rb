class CoursesController < ApplicationController
	before_action :admin_user, only:[:new]

	def show
		@course = Course.find(params[:id])
	end

	def index
		@courses = Course.all
	end
	def new
		@course = Course.new
	end
	def create
		course = Course.new(course_params)
		if course.save
			flash[:success] = "Course Created"
			redirect_to course
		else
			flash[:danger] = "Creation Failed" 
			redirect_to '/admin'
		end
	end



	private

		def course_params
			return params.require(:course).permit(:crn,:course_name,:course_number,:time)
		end
end
