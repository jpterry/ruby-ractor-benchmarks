require_relative "benchmark_help"

init_benchmark_script(
  name: "Fibonacci",
  file: __FILE__,
)

PARALLELISM = 4

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

Benchmark.bm do |x|
  x.report('sequential') { synchronous_fib(PARALLELISM, 38) }
  x.report('threaded') { threaded_fib(PARALLELISM, 38) }
  x.report('ractors') { ractor_fib(PARALLELISM, 38) }
end
