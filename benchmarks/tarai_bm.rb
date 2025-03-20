require_relative "benchmark_helper"

setup_benchmark(
  name: "Tarai",
  file: __FILE__,
)

CONCURRENCY = 4
STARTING_PARAMS = [14, 7, 0].freeze

def tarai(x, y, z) =
  x <= y ? y : tarai(tarai(x-1, y, z),
                     tarai(y-1, z, x),
                     tarai(z-1, x, y))

# Calls tarai n times serially.
# Used as a baseline for comparison.
def serial_tarai(n)
  n.times.map { tarai(*STARTING_PARAMS) }
end

def threaded_tarai(n)
  n.times.map do
    Thread.new { tarai(*STARTING_PARAMS) }
  end.map(&:value)
end

def ractor_tarai(n)
  n.times.map do
    Ractor.new { tarai(*STARTING_PARAMS) }
  end.map(&:take)
end

start_benchmark
Benchmark.bm(15, ">times faster:") do |x|
  # Uncomment below to see that threaded matches serial almost exactly
  s = x.report('serial') { serial_tarai(CONCURRENCY) } unless ENV['SKIP_SERIAL']
  t = x.report('threaded') { threaded_tarai(CONCURRENCY) }
  r = x.report('ractors') { ractor_tarai(CONCURRENCY) }
  [t/r]
end
end_benchmark
