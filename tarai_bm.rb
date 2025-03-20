require_relative "benchmark_help"

setup_benchmark(
  name: "Tarai",
  file: __FILE__,
)

PARALLELISM = 4
STARTING_PARAMS = [14, 7, 0].freeze

def tarai(x, y, z) =
  x <= y ? y : tarai(tarai(x-1, y, z),
                     tarai(y-1, z, x),
                     tarai(z-1, x, y))


def seq_tarai(n)
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
Benchmark.bm do |x|
  x.report('sequential') { seq_tarai(PARALLELISM) }
  x.report('threaded') { threaded_tarai(PARALLELISM) }
  x.report('ractors') { ractor_tarai(PARALLELISM) }
end
