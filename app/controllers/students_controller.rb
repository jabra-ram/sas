# frozen_string_literal: true

# This is students controller
class StudentsController < ApplicationController
  include StudentsHelper
  def index
    @students = Student.all.order(:id)
  end

  def new
    @student = Student.new
  end

  def show
    @student = Student.find(params[:id])
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

  def student_data
    @student = Student.find(params[:id])
    respond_to do |format|
      format.json { render json: @student }
    end
  end

  def purge_document
    doc = ActiveStorage::Attachment.find(params[:id])
    doc.purge
    redirect_back fallback_location: '/', alert: 'document deleted!'
  end

  def search
    @students = search_obj(params, Student)
  end

  def payment_status
    @student = Student.find_by_email(params[:email])
    payment_status_messages = { 'Approved' => 'approved', 'Processed' => 'processed',
                                'Rejected' => 'rejected', 'Pending' => 'pending' }
    payment_status = @student&.payment&.[](:status)
    print_payment_status(payment_status, payment_status_messages)
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :date_of_birth, :age, :class_category_id,
                                    :section_id, :academic_year, :father_name, :mother_name,
                                    :address, :contact_number, :photo, :docs)
  end
end
