class OrderMailer < ApplicationMailer
  default from: "yuxianglishun.cn<no-reply@yuxianglishun.cn>"

  def success_mail(user, order)
  	@user = user
  	@order = order
  	mail(to: @user.email, subject: '成功购票！')
  end
end
