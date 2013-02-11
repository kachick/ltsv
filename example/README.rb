require 'pp'
require_relative '../lib/ltsv'

LTSV.for_io DATA do |row|
  pp row
end

__END__
time:[28/Feb/2013:12:00:00 +0900]	host:192.168.0.1	req:GET /list HTTP/1.1	status:200	size:5316	referer:-	ua:Mozilla/5.0	taken:9789	isrobot:1	dos:-	harddos:-	cache:-
time:[28/May/2013:12:00:00 +0900]	size:5316	host:192.168.0.1	req:GET /list HTTP/1.1	status:433	referer:-	ua:Mozilla/5.0	taken:9789	isrobot:1	dos:-	harddos:-	cache:-