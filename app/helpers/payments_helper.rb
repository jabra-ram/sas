# frozen_string_literal: true

# This is payments helper
module PaymentsHelper
  def save_payment
    unless Payment.find_by(student_id: payment_params[:student_id]).nil?
      flash.now[:alert] = 'payment for this student already exists!!!'
      return render :new
    end
    if @payment.save
      send_payment_notification if %w[Rejected Pending].include?(@payment[:status])
      redirect_to payments_path, notice: 'Record saved!'
    else
      render :new
    end
  end

  def send_payment_notification
    student_name = @payment.student.name
    message = "The payment status of #{student_name} is set to #{@payment[:status]} by #{current_admin[:email]}"
    message_mail = "Your payment status is '#{@payment[:status]}'."
    ActionCable.server.broadcast('notification_channel', message)
    AdminMailer.with(student: @payment.student, message: message_mail).status_email.deliver_now
    create_notification_admin(message)
  end

  def create_notification_admin(message)
    Admin.where.not(id: current_admin[:id]).each do |admin|
      Notification.create(recipient_id: admin[:id], sender_id: current_admin[:id], message:,
                          read_status: false)
    end
  end

  def invoice_pdf(payment)
    student = payment.student
    Prawn::Document.new do |pdf|
      before_initialize_pdf(student, pdf, payment)
      invoice_services_totals_data = [
        ['Total', "#{student.class_category.fee_structure[:total]} INR"],
        ['Amount Paid', "#{payment[:amount]} INR"],
        ['Amount Due', "#{student.class_category.fee_structure[:total] - payment[:amount]} INR"]
      ]
      render_invoice_table(pdf, invoice_services_totals_data, 325)
    end
  end

  private

  def before_initialize_pdf(student, pdf, payment)
    address_x = 35
    invoice_header_x = 325
    initialize_pdf(pdf)
    render_invoice_header(pdf, address_x)
    render_student_details(pdf, student)
    render_payment_status(pdf, payment, invoice_header_x)
  end

  def initialize_pdf(pdf)
    pdf.text 'Invoice', align: :center, size: 30
    pdf.stroke_horizontal_rule
    pdf.move_down 5

    pdf.font 'Helvetica'
    pdf.font_size 12
  end

  def render_invoice_header(pdf, address_x)
    pdf.text_box 'XYZ school, Jaipur', at: [address_x, pdf.cursor], size: 16, align: :center
    pdf.move_cursor_to pdf.bounds.height
    pdf.move_down 100
  end

  def render_student_details(pdf, student)
    pdf.text "Student ID: #{student.id}", style: :bold, margin_left: 25
    pdf.text "Name: #{student.name}"
    pdf.text "Father Name: #{student.father_name}"
    pdf.text "Email: #{student.email}"
    pdf.text "Contact: #{student.contact_number}"
    pdf.text "Date of birth: #{student.date_of_birth}"
    pdf.text "Class: #{student.class_category.classname}"
    pdf.text "Address: #{student.address}"
  end

  def render_payment_status(pdf, payment, invoice_header_x)
    last_measured_y = pdf.cursor
    pdf.text_box "Payment Status:  #{payment.status}", at: [invoice_header_x, 625], style: :bold
    pdf.move_down 30
    pdf.move_cursor_to last_measured_y
  end

  def render_invoice_table(pdf, data, invoice_header_x)
    pdf.move_cursor_to 600
    pdf.table(data, position: invoice_header_x, width: 215) do
      style(row(0..1).columns(0..1), padding: [1, 5, 1, 5], borders: [])
      style(row(0), font_style: :bold)
      style(row(2), background_color: 'e9e9e6', border_color: 'dddddd', font_style: :bold)
      style(column(1), align: :right)
      style(row(2).columns(0), borders: %i[top left bottom])
      style(row(2).columns(1), borders: %i[top right bottom])
    end
  end
end
