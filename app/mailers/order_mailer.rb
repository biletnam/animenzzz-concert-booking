class OrderMailer < ApplicationMailer
  default from: "Animenz 2016 Live<no-reply@notice.yuxianglishun.cn>"

  def success_mail(user, order)
  	@user = user
  	@order = order
  	mail(to: @user.email, subject: '成功购票！')
  end

  def delete_mail(user, order)
  	@user = user 
  	@order = order 
  	mail(to: @user.email, subject: '删除订单！')
  end

  def pay_time_mail(user)
  	@user = user
  	mail(to: @user.email, subject: '付款通知')
  end
end
