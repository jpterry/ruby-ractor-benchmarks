require_relative "benchmark_help"

setup_benchmark(
  name: "Fibonacci",
  file: __FILE__,
)

CONCURRENCY = 4
FIB_NUM = 38

def fibonacci(n)
  if n == 0 || n == 1
    n
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

def synchronous_fib(concurrency, n)
  concurrency.times.map do
    fibonacci(n)
  end
end

def threaded_fib(concurrency, n)
  concurrency.times.map do
    Thread.new { fibonacci(n) }
  end.map(&:value)
end

def ractor_fib(concurrency, n)
  concurrency.times.map do
    Ractor.new(n) { |num| fibonacci(num) }
  end.map(&:take)
end

start_benchmark
Benchmark.bm(10) do |x|
  x.report('sequential') { synchronous_fib(CONCURRENCY, FIB_NUM) }
  x.report('threaded') { threaded_fib(CONCURRENCY, FIB_NUM) }
  x.report('ractors') { ractor_fib(CONCURRENCY, FIB_NUM) }
end
end_benchmark
