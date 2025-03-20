task default: ['benchmark:all']

namespace :benchmark do
  task :tarai do
    ruby "tarai_bm.rb"
  end

  task :tarai_yjit do
    ruby "--yjit", "tarai_bm.rb"
  end

  task :fibo do
    ruby "fibo_bm.rb"
  end

  task :fibo_yjit do
    ruby "--yjit", "fibo_bm.rb"
  end

  task all: [
    :fibo,
    :fibo_yjit,
    :tarai,
    :tarai_yjit,
  ]
end
