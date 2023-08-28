# frozen_string_literal: true

# This is student helper
module StudentsHelper
  def attach_documents
    params[:student][:photo] && @student.photo.attach(params[:student][:photo])
    params[:student][:docs] && @student.docs.attach(params[:student][:docs])
  end

  def print_payment_status(payment_status, payment_status_messages)
    if @student
      if payment_status_messages.key?(payment_status)
        redirect_to login_path, notice: "Your payment is #{payment_status_messages[payment_status]}."
      elsif payment_status.nil?
        redirect_to login_path, alert: 'Your payment is yet not created!'
      end
    else
      redirect_to login_path, alert: 'Student does not exist!'
    end
  end
end
