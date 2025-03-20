task default: ['benchmark:all']

namespace :benchmark do
  desc "Run Tarai benchmark"
  task tarai: [:start] do
    ruby_run_bm "tarai_bm.rb"
  end

  desc "Run Tarai benchmark, YJIT enabled"
  task tarai_yjit: [:start] do
    ruby_run_bm "tarai_bm.rb", yjit: true
  end

  desc "Run Fibonacci benchmark"
  task fibo: [:start] do
    ruby_run_bm "fibo_bm.rb"
  end

  desc "Run Fibonacci benchmark, YJIT enabled"
  task fibo_yjit: [:start] do
    ruby_run_bm "fibo_bm.rb", yjit: true
  end

  desc "Run Fibonacci benchmark serially, comparing without & with YJIT"
  task fibo_serial_yjit: [:start] do
    ruby_run_bm "fibo_ractor_yjit.rb"
  end

  desc "Run Fibonacci benchmark in ractors, comparing without & with YJIT"
  task fibo_ractor_yjit: [:start] do
    ruby_run_bm "fibo_ractor_yjit.rb"
  end

  def ruby_run_bm(*args, yjit: nil, **options)
    args.unshift("benchmarks/#{args.shift}")

    if yjit
      args.unshift("--yjit")
    end

    ruby(*args, **options)
  end

  task :start do
    puts "Running benchmark tasks..."
    require_relative "lib/hwinfo"
    Hwinfo.print_info
    puts ""
  end

  desc "Run all benchmarks"
  task all: [
    :fibo,
    :fibo_yjit,
    :tarai,
    :tarai_yjit,
    :fibo_serial_yjit,
    :fibo_ractor_yjit,
  ]
end
