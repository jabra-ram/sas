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
        InvoiceMailer.with(student: @payment.student, invoice: pdf).invoice_email.deliver_now
        redirect_to payments_path, notice:"Invoice mail sent to student!"
    end
    private 
        def payment_params
            params.require(:payment).permit(:student_id, :mode_of_payment, :amount, :status, :notes)
        end
end
