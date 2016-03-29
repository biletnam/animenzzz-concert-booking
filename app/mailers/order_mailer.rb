class OrderMailer < ApplicationMailer
  default from: "Animenz 2016 Live<no-reply@notice.yuxianglishun.cn>"

  def success_mail(user, order)
  	@user = user
  	@order = order
  	mail(to: @user.email, subject: '成功购票！')
  end
end
