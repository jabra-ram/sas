class AdminsController < ApplicationController
    before_action :authorize, only:[:index]

    def index
    end

    def invite
        @invitation = Invitation.find_by(token: params[:token])
        if @invitation==nil
            flash[:alert] = "Invalid invitation link!!!"
            redirect_to login_path
        elsif @invitation.expires_at<Time.now
            flash[:alert] = "Invitation link expired!!!"
            redirect_to login_path
        end
        @admin = Admin.new
    end

    def process_invite
        @invitation = Invitation.find_by(token: params[:token])
        @admin = Admin.new(email: @invitation.email, password: params[:admin][:password], password_confirmation: params[:admin][:password_confirmation])
      
        if @admin.save
            AdminMailer.with(admin: @admin).confirmation_email.deliver_now
            @invitation.destroy
            flash[:notice] = "Thank you for signing up! You can login now."
            redirect_to login_path
        else
            flash[:alert] = "Something Went Wrong!!!"
            render "invite"
        end
    end 

    def admin_params
        params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end
