class StudentsController < ApplicationController
	def index 
		@students = Student.all 
	end
	def new
		@student = Student.new
	end
	def show
		@student = Student.find(params[:id])
		respond_to do |format|
				format.json { render json: @student }
		end
	end
	def create 
		@student = Student.new(student_params)
		if @student.save
			@student.photo.attach(params[:student][:photo])
			@student.docs.attach(params[:student][:docs])
			redirect_to students_path, notice:"Record saved!"
		else
			render :new, alert:"Something went wrong!!!"
		end
	end
	def edit
		@student = Student.find(params[:id])
	end
	def update 
		@student = Student.find(params[:id])
		if @student.update(student_params)
			params[:student][:photo] && @student.photo.attach(params[:student][:photo])
			params[:student][:docs] && @student.docs.attach(params[:student][:docs])
			redirect_to students_path, notice:"Record updated!"
		else
			redirect_to edit_student_path, alert:"Something went wrong!!!"
		end
	end
	def destroy
		@student = Student.find(params[:id])
		if @student.destroy
			redirect_to students_path, notice:"Record deleted!"
		else
			render :new, alert:"Something went wrong!!!"
		end
	end 
	def search 
		query = params[:search_students].presence && params[:search_students][:query]
		filter_column = params[:search_students].presence && params[:search_students][:filter_column]
		filter_value = params[:search_students].presence && params[:search_students][:filter_value]
		sort_by = params[:search_students].presence && params[:search_students][:sort_by]
		if query
				@students = Student.search_query(query, filter_column, filter_value, sort_by).records
		end
	end
	private 
	def student_params
		params.require(:student).permit(:name, :email, :date_of_birth, :age, :class_category_id, :section_id, :academic_year, :father_name, :mother_name, :address, :contact_number)
	end
end
