# Preview all emails at http://localhost:3000/rails/mailers/thanks_mailer
class ThanksMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/thanks_mailer/registration_confirmation
  def registration_confirmation
    ThanksMailer.registration_confirmation
  end

end
