# frozen_string_literal: true

RSpec.describe GraphiQLRack do
  it "has a version number" do
    expect(GraphiQLRack::VERSION).not_to be nil
  end

  it "renders graphiql" do
    status, headers, body = ::GraphiQLRack.call({})

    expect(status).to eq(200)
    expect(body).to include(/react.production.min.js/)
    expect(body).to include(/react-dom.production.min.js/)
    expect(body).to include(/window\["GraphiQL"\]/)
  end

  context "without rails configured params" do
    it "falls back to default endpoint" do
      status, headers, body = ::GraphiQLRack.call({})

      expect(status).to eq(200)
      expect(body).to include(/window.location.origin \+ "\/graphql"/)
    end
  end

  context "with rails configure params" do
    it "accepts the configured endpoint" do
      status, headers, body = ::GraphiQLRack.call({
        "action_dispatch.request.path_parameters" => { endpoint: "/cool_graphql" }
      })

      expect(status).to eq(200)
      expect(body).to include(/window.location.origin \+ "\/cool_graphql"/)
    end
  end
end
