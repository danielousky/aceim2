class InstructorSessionController < ApplicationController

	before_action :authenticate_user!
	
	def index
		if params[:id]
			@user =  User.find(params[:id])
		else
			@user = current_user
		end
		@instructor = @user.instructor
	end


	def show_sections
		@section = Section.find params[:id]
	end
end
