class EnrollmentsController < ApplicationController
	before_action :signed_in_user
	def create
		current_user.enroll!(params[:enrollment][:course_id])
		redirect_to root_url
	end
end
