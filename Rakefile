task default: ['benchmark:all']

namespace :benchmark do
  task :start do
    puts "Running benchmark tasks..."
    require_relative "hwinfo"
    Hwinfo.print_info
    puts ""
  end

  task tarai: [:start] do
    ruby "tarai_bm.rb"
  end

  task tarai_yjit: [:start] do
    ruby "--yjit", "tarai_bm.rb"
  end

  task fibo: [:start] do
    ruby "fibo_bm.rb"
  end

  task fibo_yjit: [:start] do
    ruby "--yjit", "fibo_bm.rb"
  end

  task all: [
    :fibo,
    :fibo_yjit,
    :tarai,
    :tarai_yjit,
  ]
end
