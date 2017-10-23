Shelf::Server.start(
  app: ->(e) {
    [200, { 'Content-Type' => 'text/html' }, ['hello world from Mruby']]
  },
  server: 'simplehttpserver',
  port: ENV['PORT']
)