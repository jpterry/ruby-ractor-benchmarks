# Ruby Ractor Benchmarks
This isn't an organized piece of work. It's a collection of scripts to benchmark Ractors in ruby 3.4.

Inclues some benchmark helpers to make output consistent across scripts.

## Usage
The requirement are very minimal. Only stdlib ruby and default gems should be required.

### Run all benchmarks
Rake should run all the benchmarks. See the [`Rakefile`](Rakefile) for details.
```
rake
```

### Build and Run Docker Container
To get more consistent results, a docker container can be built and run.

```
img_tag="jpterry/ruby-ractor-benchmarks:test"
docker build . -t "$img_tag"
docker run --rm -it "$img_tag"
# Capture the output and send it to me if you want.
```

## Code
See [`benchmarks/`](benchmarks/) for the benchmark scripts. They can each be run directly with ruby. eg `ruby benchmarks/fibo_bm.rb`.
