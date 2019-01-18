web: bundle exec puma -p ${PORT:-3000} -e ${RACK_ENV:-development}
release: bundle exec rails db:migrate
worker: bundle exec sidekiq -C config/sidekiq.yml
