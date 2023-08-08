# frozen_string_literal: true

# This is students controller
class StudentsController < ApplicationController
  include StudentsHelper
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
      attach_documents
      redirect_to students_path, notice: 'Record saved!'
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      attach_documents
      redirect_to students_path, notice: 'Record updated!'
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    if @student.destroy
      redirect_to students_path, notice: 'Record deleted!'
    else
      render :new
    end
  end

  def search
    @students = search_obj(params, Student)
  end

  def payment_status
    @student = Student.find_by_email(params[:email])
    payment_status_messages = { 'Approved' => 'approved', 'Processed' => 'processed',
                                'Rejected' => 'rejected', 'Pending' => 'pending' }
    payment_status = @student&.payment&.[](:status)
    if payment_status_messages.key?(payment_status)
      redirect_to login_path, notice: "Your payment is #{payment_status_messages[payment_status]}."
    else
      redirect_to login_path, alert: 'Student does not exist!'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :date_of_birth, :age, :class_category_id,
                                    :section_id, :academic_year, :father_name, :mother_name,
                                    :address, :contact_number, :photo, :docs)
  end
end
