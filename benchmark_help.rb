require "benchmark"
require "etc"

require_relative "hwinfo"
require_relative "ruby_info"

def silence_reactor_warning
  Warning[:experimental] = false
end

def setup_benchmark(...)
  set_benchmark(...)
  print_header(...)
end

def set_benchmark(name: nil, file: nil)
  @name = name
  @file = file
end

def start_benchmark
  silence_reactor_warning
  puts "Running #{benchmark_name(name: @name, file: @file)} @ #{bench_start_time = Time.now}...\n"
end

def benchmark_name(name: nil, file: nil)
  if name && file
    "#{name} benchmark from #{file}"
  elsif name
    "#{name} benchmark"
  elsif file
    "benchmark from #{file}"
  else
    "benchmark"
  end
end

def print_header(name: nil, file: nil)
  puts "Initializing #{benchmark_name(name: name, file: file)}..."
  RubyInfo.print_info
end
