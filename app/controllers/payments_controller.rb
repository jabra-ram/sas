class PaymentsController < ApplicationController
    def index 
        @payments = Payment.all 
    end
    def new
        @payment = Payment.new
    end
    def create 
        @payment = Payment.new(payment_params)
        if @payment.save
            redirect_to payments_path, notice:"Record saved!"
        else
            render "new", alert:"Something went wrong!!!"
        end
    end
    def destroy
        @payment = Payment.find(params[:id])
        if @payment.destroy
            redirect_to payments_path, notice:"Record deleted!"
        else
            render "new", alert:"Something went wrong!!!"
        end
    end 
    def generate_invoice
        @payment = Payment.find(params[:id])
        pdf = Prawn::Document.new
        pdf.text "hello world"
        send_data(pdf.render, filename:"invoice.pdf", type:"application/pdf")
    end

    private 
        def payment_params
            params.require(:payment).permit(:student_name, :email, :classname, :academic_year, :address, :contact_number, :mode_of_payment, :amount, :status, :notes)
        end
end
