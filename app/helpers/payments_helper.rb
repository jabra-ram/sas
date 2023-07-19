module PaymentsHelper
    def invoice_pdf(payment)
        student = payment.student
        Prawn::Document.new do |pdf|
            initial_y = pdf.cursor
            initialmove_y = 5
            address_x = 35
            invoice_header_x = 325
            lineheight_y = 12
            font_size = 12
            
            pdf.text 'Invoice', align: :center, size:30
            pdf.stroke_horizontal_rule
            pdf.move_down initialmove_y

            # Add the font style and size
            pdf.font "Helvetica"
            pdf.font_size font_size

            # Start with your school name and address
            pdf.text_box "XYZ school, Jaipur", :at => [address_x,  pdf.cursor], size:16, align: :center

            last_measured_y = pdf.cursor
            pdf.move_cursor_to pdf.bounds.height
            # Student details
            pdf.move_down 100
            last_measured_y = pdf.cursor

            pdf.text "Student ID: #{student.id}", style: :bold, margin_left: 25
            pdf.text "Name: #{student.name}"
            pdf.text "Father Name: #{student.father_name}"
            pdf.text "Email: #{student.email}"
            pdf.text "Contact: #{student.contact_number}"
            pdf.text "Date of birth: #{student.date_of_birth}"
            pdf.text "Class: #{student.class_category.classname}"
            pdf.text "Academic year: #{student.academic_year}"
            pdf.text "Address: #{student.address}"
            pdf.move_cursor_to last_measured_y
            pdf.text_box "Payment Status:  #{payment.status}", :at=>[invoice_header_x, pdf.cursor], style: :bold
            pdf.move_down 30
            last_measured_y = pdf.cursor
            invoice_services_totals_data = [ 
              ["Total", "90000 INR"],
              ["Amount Paid", "#{payment[:amount]} INR"],
              ["Amount Due", "#{90000 - payment[:amount]} INR"]
            ]
          
            pdf.table(invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
              style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
              style(row(0), :font_style => :bold)
              style(row(2), :background_color => 'e9e9e6', :border_color => 'dddddd', :font_style => :bold)
              style(column(1), :align => :right)
              style(row(2).columns(0), :borders => [:top, :left, :bottom])
              style(row(2).columns(1), :borders => [:top, :right, :bottom])
            end
        end
    end
end  