# frozen_string_literal: true

module Notifications
  extend ActiveSupport::Concern

  protected

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
