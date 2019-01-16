# frozen_string_literal: true

class EmailWorker
  include Sidekiq::Worker

  def perform(user, text); end
end
