class ApplicationController < ActionController::API
  attr_writer :start_bench_time, :execution_time

  def start_benchmark
    @start_bench_time = Time.now
  end

  def finish_benchmark
    finish = Time.now
    diff = (finish - @start_bench_time) * 1000.0
    @execution_time = "#{diff.round} ms"
  end
end
