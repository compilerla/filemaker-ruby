module XmlLoader
  def import_xml_as_string(filename)
    File.read(File.dirname(__FILE__) + '/responses/' + filename)
  end

  def fake_post_response(server, body, xml)
    server.connection.builder.use Faraday::Adapter::Test do |stub|
      stub.post '/fmi/xml/fmresultset.xml', body do
        [200, {}, import_xml_as_string(xml)]
      end
    end
  end

  def fake_get_response(server, query_string, xml)
    server.connection.builder.use Faraday::Adapter::Test do |stub|
      stub.get "/fmi/xml/fmresultset.xml?#{query_string}" do
        [200, {}, import_xml_as_string(xml)]
      end
    end
  end

  def fake_error(server, body, status_code)
    server.connection.builder.use Faraday::Adapter::Test do |stub|
      stub.post '/fmi/xml/fmresultset.xml', body do
        [status_code, {}, '']
      end
    end
  end
end
