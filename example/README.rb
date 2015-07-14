require 'pp'
require_relative '../lib/ltsv'

pp LTSV.parse_line "key1:val1	key2:val2\n" #=> {:key1=>"val1", :key2=>"val2"}

pp LTSV.parse 'key1:val1	key2:val2
key1:val1	key2:val2	key3:val3' #=> [{:key1=>"val1", :key2=>"val2"}, {:key1=>"val1", :key2=>"val2", :key3=>"val3"}]

pp LTSV.line_from_hash({:key1=>"val1", :key2=>"val2"}) #=> "key1:val1	key2:val2"

LTSV.for_io DATA do |row|
  pp row
end

__END__
time:[28/Feb/2013:12:00:00 +0900]	host:192.168.0.1	req:GET /list HTTP/1.1	status:200	size:5316	referer:-	ua:Mozilla/5.0	taken:9789	isrobot:1	dos:-	harddos:-	cache:-
time:[28/May/2013:12:00:00 +0900]	size:5316	host:192.168.0.1	req:GET /list HTTP/1.1	status:433	referer:-	ua:Mozilla/5.0	taken:9789	isrobot:1	dos:-	harddos:-	cache:-
