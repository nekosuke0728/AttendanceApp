class AccountMailer < ApplicationMailer
  default from: 'admin@sample.com'

  def account_email(user)
    @user = user
    mail to:      @user.email,
         subject: 'ユーザー新規登録のご案内'
  end

end
