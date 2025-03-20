ARG RUBY_VERSION=3.4.2

FROM ruby:${RUBY_VERSION}

# Doesn't even require Bundler today.
# Straight Ruby. No Dependencies.
WORKDIR /opt/ruby_benchmarks
COPY . .

CMD ["rake"]
