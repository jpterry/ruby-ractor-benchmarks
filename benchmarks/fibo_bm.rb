require_relative "benchmark_helper"

setup_benchmark(
  name: "Fibonacci",
  file: __FILE__,
)

CONCURRENCY = 6
FIB_NUM = 38

# This is a naive recursive Fibonacci implementation.
# Pretty slow for anything > 35
def fibonacci(n)
  ((n == 0 || n == 1) && n) || fibonacci(n - 1) + fibonacci(n - 2)
end

# Calls fibonacci n times serially.
# Used as a baseline for comparison.
def serial_fibonacci(concurrency, n)
  concurrency.times.map do
    fibonacci(n)
  end
end

def threaded_fibonacci(concurrency, n)
  concurrency.times.map do
    Thread.new { fibonacci(n) }
  end.map(&:value)
end

def ractor_fibonacci(concurrency, n)
  concurrency.times.map do
    Ractor.new(n) { |num| fibonacci(num) }
  end.map(&:take)
end

start_benchmark
Benchmark.bm(15, ">times faster:") do |x|
  # Uncomment below to see that threaded matches serial almost exactly
  s = x.report('serial')   { serial_fibonacci(CONCURRENCY, FIB_NUM) } unless ENV['SKIP_SERIAL']
  t = x.report('threaded') { threaded_fibonacci(CONCURRENCY, FIB_NUM) }
  r = x.report('ractors')  { ractor_fibonacci(CONCURRENCY, FIB_NUM) }
  [t/r]
end
end_benchmark
