require "test_helper"

class LangMini::ClientTest < Minitest::Test
  def setup
    LangMini.logger.level = Logger::WARN
  end
  
  def test_initialize
    client = LangMini::Client.new(access_token: "TOKEN")

    assert(client.is_a?(LangMini::Client))
  end

  def test_models
    client = LangMini::Client.new(access_token: "TOKEN")

    OpenRouter::Client.any_instance.expects(:models).returns(
      [
        { "id" => "model_1"},
        { "id" => "model_2"},
      ]
    )

    models = client.models
    
    assert_equal(2, models.count)
    assert_equal("model_1", models[0])
    assert_equal("model_2", models[1])
  end

  def test_models_should_call_open_router_only_once
    client = LangMini::Client.new(access_token: "TOKEN")

    OpenRouter::Client.any_instance.expects(:models).returns([{"id" => "MODEL"}]).once

    assert_equal(["MODEL"], client.models)
    assert_equal(["MODEL"], client.models)
  end

  def test_complete
    messages_hash = [
      {
        "role": "system",
        "content": "You are a gentel assistant."
      },
      {
        "role": "user",
        "content": "hello"
      }
    ]

    expected_request_body = {
      "messages"=> [
        {"role"=>"system", "content"=>"You are a gentel assistant."},
        {"role"=>"user", "content"=>"hello"}
      ],
      "model"=>"openrouter/auto",
      "temperature"=>0.8
    }

    stub_request(:post, "https://openrouter.ai/api/v1/chat/completions").
      with(body: expected_request_body.to_json).
      to_return(
        status: 200, 
        body: read_fixture("lang_mini/client_complete.json"),
        headers: {content_type: 'application/json'}
      )

    client = LangMini::Client.new(access_token: "TOKEN") 

    response = 
      client.complete(
        messages_hash, 
        model: "openrouter/auto",
        extras: {
          temperature: 0.8
        }
      )
    
    assert_equal("gen-1728588645-bB3Kh9AMJQ0J943j4QEn", response["id"])
    assert_equal(68, response["usage"]["total_tokens"])
    assert(response["choices"][0]["message"]["content"].include?("Good day to you"))
  end
end
