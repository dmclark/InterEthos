class UserMailer < ActionMailer::Base
  default :from => "josh@swithin.com"
  # default :sent_on => Time.now

  def activation_instructions(user)
    @user=user
    attachments["InterEthos.gif"] = File.read("#{Rails.root}/public/images/InterEthos_logo.gif")
    mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "InterEthos - Activation Instructions")
  end

  def welcome(user)
    @user=user
    attachments["InterEthos.gif"] = File.read("#{Rails.root}/public/images/InterEthos_logo.gif")
    mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "InterEthos - Welcome!")
  end
end
