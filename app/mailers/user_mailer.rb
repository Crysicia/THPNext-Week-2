# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'recommendation@next.alpha'
  def offer(user, text)
    @user = user
    @text = text
    mail(to: @user.email, subject: 'Check out our new offer!')
  end
end
