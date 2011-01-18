class UserMailer < ActionMailer::Base

  def forgot_password(user)
    setup_email(user)
  end

protected

  def setup_email(user)
    @recipients  = user.email
    @from        = "enjoyoung_mailer@enjoyoung.cn"
    @sent_on     = Time.now
    @subject     = '您请求了一个新的密码'
    @body[:user] = user
  end

end
