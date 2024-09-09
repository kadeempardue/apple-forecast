# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc 'Drops, recreates, and reseeds database'
    task :danger do
      abort 'Cannot use this task in production!' if Rails.env.production?

      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
    end
  end
end
