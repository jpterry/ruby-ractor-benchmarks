require "benchmark"
require "etc"

require_relative "hwinfo"

def silence_reactor_warning
  Warning[:experimental] = false
end

def setup_benchmark(...)
  print_header(...)
end

def start_benchmark
  silence_reactor_warning
  puts "Starting Benchmark @ #{bench_start_time = Time.now}"
end

def print_header(name: nil, file: nil)
  if name && file
    puts "Running #{name} benchmark from #{file}"
  elsif name
    puts "Running #{name} benchmark "
  elsif file
    puts "Running benchmark from #{file}"
  end

  puts "Ruby Info:"
  pp ruby_info
  puts "Hardware Info:"
  pp collect_info

end

def ruby_info
  {
    RUBY_DESCRIPTION: RUBY_DESCRIPTION,
    RUBYOPT: ENV['RUBYOPT'],
    CONFIG_MAINLIBS: RbConfig::CONFIG['MAINLIBS'],
    CONFIG_LIBS: RbConfig::CONFIG['LIBS'],
    YJIT_enabled: defined?(RubyVM::YJIT) && RubyVM::YJIT.respond_to?(:enabled?) && RubyVM::YJIT.enabled?,
    MJIT_enabled: defined?(RubyVM::MJIT) && RubyVM::MJIT.respond_to?(:enabled?) && RubyVM::MJIT.enabled?,
  }.compact
end

def collect_info
  {
    cpu_physical_cores: Hwinfo.cpu_pysical_cores,
    cpu_logical_cores: Hwinfo.cpu_logical_cores,
    cpu_model: Hwinfo.cpu_model,
    machine: Hwinfo.uname[:machine],
    os_name: Hwinfo.uname[:sysname],
    os_release:  Hwinfo.uname[:release],
    os_version:  Hwinfo.uname[:version],
    mem_total_mb: Hwinfo.mem_total_mb,
  }
end
