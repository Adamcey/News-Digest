class Emailer < ActionMailer::Base
  default from: 'no-reply@yuszy.com'

  def sendEmail user, articles
    @articles = articles
  	mail(to: user.email, subject: "hello #{user.username}, new Articles coming!")
  end
end
