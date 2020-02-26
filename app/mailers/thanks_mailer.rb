class ThanksMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.thanks_mailer.registration_confirmation.subject
  #
  def registration_confirmation(user)
    @user = user
    @greeting = "Hi" + @user.name
    mail to: @user.email, subject: '新規登録完了のご連絡'
  end
end
