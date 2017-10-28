include Yeah

opt! :help do
  <<-usage

usage: app [options...]
Options:
-e, --environment The environment to run the server with.
-p, --port        The port number to start the local server on.
                  Defaults to: 3000
-s, --server      The server to use for.
-h, --help        This help text
-v, --version     Show version number
usage
end

opt! :version do
  '0.1'
end

opt :port, 3000 do |port|
  set :port, port
end

opt :server, 'simplehttpserver' do |server|
  set :server, server
end

opt :environment, 'development' do |env|
  ENV['SHELF_ENV'] = env
end

# use Shelf::Static, urls: ['/public'], root: ENV['DOCUMENT_ROOT']

get '/' do
  'Hello from mruby Yeah!'
end

get '/pg' do
  # conn_string = "postgresql://postgresql:12345678@mydbinstance1-cluster.cluster-cqkcekoiglpj.us-west-2.rds.amazonaws.com/luisbebop"
  conn_string = "postgresql://postgresql:12345678@mydbinstance1-cluster.cluster-ro-cqkcekoiglpj.us-west-2.rds.amazonaws.com/luisbebop"
  conn = Pq.new(conn_string)
  res = conn.exec("select * from world where id=#{Random::rand(2195)};")
  conn.close
  res.values.to_s
end

get "/foo.js" do
'
$(function() {
  $("#foo").text("hello world");
})
'
end

get "/form" do
  render html:
'
<html>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="foo.js"></script>
<div id="foo"></div>
<form action="add" method="post">
<label for="name"/>Type your name</label>
<input type="text" id="name" name="name" value="">
<input type="submit">
</form>
</html>
'
end

post "/add" do
  request.to_s
end

yeah!(ARGV)