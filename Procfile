web: bundle exec puma -t 2:16 -p ${PORT:-3000}
worker: bundle exec sidekiq -e production -C config/sidekiq.yml -c 16
release: bundle exec rake db:migrate