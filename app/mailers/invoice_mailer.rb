# frozen_string_literal: true

# This is invoice mailer
class InvoiceMailer < ApplicationMailer
  default from: 'jrchoudhary2410@gmail.com'
  def invoice_email
    @student = params[:student]
    attachments['invoice.pdf'] = { mime_type: 'application/pdf', content: params[:invoice].render }
    mail(to: @student.email, subject: 'Invoice of fee payment')
  end
end
