# frozen_string_literal: true

# This is module AdminsHelper
module AdminsHelper
  def save_admin
    Invitation.where(email: @invitation.email).destroy_all
    AdminMailer.with(admin: @admin).confirmation_email.deliver_now
  end
end
