# coding: us-ascii
require_relative 'spec_helper'

describe LTSV do
  
  # @see http://ltsv.org/
  let(:line) { "key1:val1	key2:val2\n" }  
  let(:parsed_hash) { {key1: 'val1', key2: "val2\n"} }

  let(:string) do
'key1:val1	key2:val2
key1:val1	key2:val2	key3:val3
'
  end
  let(:parsed_hashes) { [{key1: 'val1', key2: "val2\n"}, {key1: 'val1', key2: 'val2', key3: "val3\n"}] }
  
  let(:io) { StringIO.new string }

  context '.parse_line' do
    subject { LTSV.parse_line line }
    
    it { should eq({key1: 'val1', key2: "val2\n"})  }
  end
  
  context '.parse' do
    subject { LTSV.parse string }
    
    it { should eq(parsed_hashes)  }
  end
  
  context '.for_io' do
    context 'wihtout a block' do
      subject { LTSV.for_io(io) }
      
      it { should be_instance_of(Enumerator) }
      
      context 'the returned enumerator' do
        it 'baheves normaly' do
          expect(LTSV.for_io(io).to_a).to eq(LTSV.parse string)
        end
      end
    end
    
    context 'with a block' do
      it 'calls the block with the parsed line' do
        entries = []
        LTSV.for_io(io) do |entry|
          entries << entry
        end
        
        expect(entries).to eq(LTSV.parse string)
      end
    end
  end
  
  context '.foreach' do
    subject { LTSV.foreach(File.expand_path 'example.ltsv', __dir__).to_a }
    
    it { should eq(LTSV.parse string) }
  end
  
  context '.line_from_hash' do
    subject { LTSV.line_from_hash(parsed_hash) }
    
    it { should eq(line) }
  end

  context '.string_from_hashes' do
    subject { LTSV.string_from_hashes(parsed_hashes) }
    
    it { should eq(string) }
  end

  context 'long example' do
    let(:long_example) { "host:127.0.0.1	ident:-	user:frank	time:[10/Oct/2000:13:55:36 -0700]	req:GET /apache_pb.gif HTTP/1.0	status:200	size:2326	referer:http://www.example.com/start.html	ua:Mozilla/4.08 [en] (Win98; I ;Nav)\n" }
    
    subject { LTSV.parse_line long_example }
  
    it { should eq({
        host: "127.0.0.1",
        ident: "-",
        user: "frank",
        time: "[10/Oct/2000:13:55:36 -0700]",
        req: "GET /apache_pb.gif HTTP/1.0", 
        status: "200", 
        size: "2326", 
        referer: "http://www.example.com/start.html",
        ua: "Mozilla/4.08 [en] (Win98; I ;Nav)\n"}
        ) }
  end
end
