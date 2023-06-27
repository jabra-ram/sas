class StudentsController < ApplicationController
    def index 
        @students = Student.all 
    end
    def new
        @student = Student.new
    end
    def create 
        @student = Student.new(student_params)
        @student.photo.attach(params[:student][:photo])
        @student.docs.attach(params[:student][:docs])
        if @student.save
            redirect_to students_path, notice:"Record saved!"
        else
            render "new", alert:"Something went wrong!!!"
        end
    end
    def destroy
        @student = Student.find(params[:id])
        if @student.destroy
            redirect_to students_path, notice:"Record deleted!"
        else
            render "new", alert:"Something went wrong!!!"
        end
    end 

    private 
        def student_params
            params.require(:student).permit(:name, :date_of_birth, :age, :classname, :academic_year, :father_name, :mother_name, :address, :contact_number)
        end

end
