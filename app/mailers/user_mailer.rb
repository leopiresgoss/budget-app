class UserMailer < ApplicationMailer
  def budget_notification
    @user = params[:user]
    @message = params[:message]

    mail(to: @user.email, subject: 'Budget Notification')
  end
end
