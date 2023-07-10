class PaymentsController < ApplicationController
    include PaymentsHelper
    def index 
        @payments = Payment.all 
    end
    def new
        @payment = Payment.new
    end
    def create 
        @payment = Payment.new(payment_params)
        if @payment.save
            if @payment[:status]=='Rejected' || @payment[:status]=='Pending'
                message = "The payment status of #{@payment.student[:name]} is set to #{@payment[:status]} by #{current_admin[:email]}"
                ActionCable.server.broadcast('notification_channel', message)
                Admin.all.each do |admin|
                    if admin!=current_admin
                        Notification.create(recipient_id:admin[:id], sender_id:current_admin[:id], message:message, read_status: false)
                    end
                end
            end
            redirect_to payments_path, notice:'Record saved!'
        else
            render 'new', alert:'Something went wrong!!!'
        end
    end
    def destroy
        @payment = Payment.find(params[:id])
        if @payment.destroy
            redirect_to payments_path, notice:'Record deleted!'
        else
            render 'new', alert:'Something went wrong!!!'
        end
    end 
    def generate_invoice
        @payment = Payment.find(params[:id])
        pdf = invoice_pdf(@payment)
        send_data(pdf.render, filename:'invoice.pdf', type:'application/pdf', disposition:'inline')
    end
    def email_invoice
        @payment = Payment.find(params[:id])
        pdf = invoice_pdf(@payment)
        InvoiceMailer.with(student: @payment.student, invoice: pdf).invoice_email.deliver_later
        redirect_to payments_path, notice:"Invoice mail sent to student!"
    end
    private 
        def payment_params
            params.require(:payment).permit(:student_id, :mode_of_payment, :amount, :status, :notes)
        end
end
