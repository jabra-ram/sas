module PaymentsHelper
    def invoice_pdf(payment)
        student = payment.student
        Prawn::Document.new do |pdf|
            initial_y = pdf.cursor
            initialmove_y = 5
            address_x = 35
            invoice_header_x = 325
            lineheight_y = 12
            font_size = 9
            
            pdf.text 'Invoice', align: :center, size:30
            pdf.stroke_horizontal_rule
            pdf.move_down initialmove_y

            # Add the font style and size
            pdf.font "Helvetica"
            pdf.font_size font_size

            # Start with your school name and address
            pdf.text_box "University of Engineering and Management, Jaipur", :at => [address_x,  pdf.cursor], size:16, align: :center

            last_measured_y = pdf.cursor
            pdf.move_cursor_to pdf.bounds.height

            pdf.move_cursor_to last_measured_y

            # Student details
            pdf.move_down 65
            last_measured_y = pdf.cursor

            pdf.table(
                [['Student ID', student[:id]], ['Name', student[:name]], ['Class', student.class_category[:classname]], ['Academic Session', student[:academic_year]]],
                cell_style: { borders: [], padding: [2, 10, 2, 10] }
              ) do
                cells.borders = [:bottom, :left, :right, :top]
                cells.border_width = 0.5
                cells.border_color = '000000'
            end

            pdf.move_cursor_to last_measured_y
          
            invoice_services_totals_data = [ 
              ["Total", "#{payment[:amount]} INR"],
              ["Amount Paid", "#{payment[:amount]} INR"],
              ["Amount Due", "00.00 INR"]
            ]
          
            pdf.table(invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
              style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
              style(row(0), :font_style => :bold)
              style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
              style(column(1), :align => :right)
              style(row(2).columns(0), :borders => [:top, :left, :bottom])
              style(row(2).columns(1), :borders => [:top, :right, :bottom])
            end
        end
    end
end  