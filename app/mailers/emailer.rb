class Emailer < ActionMailer::Base
  default from: 'no-reply@yuszy.com'
  default to: 'yuszy@outlook.com'

  def sendEmail
  	mail(subject: 'hello mail')
  end
end