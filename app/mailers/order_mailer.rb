class OrderMailer < ApplicationMailer
  def hello(email)
    mail to: email, subject: "買東西通知! Mailgun"
  end
end
