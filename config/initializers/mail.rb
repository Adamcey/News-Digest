#require 'mandrill'

ActionMailer::Base.smtp_settings = {
    :address   => 'smtp.mandrillapp.com',
    :port      => 587,
    :user_name => 'sangzhouyangy@163.com',
    :password  => 'Irfi-GFoNEFLr_mNHUcy0w',
    :authentication => 'login'
  }

ActionMailer::Base.delivery_method = :smtp