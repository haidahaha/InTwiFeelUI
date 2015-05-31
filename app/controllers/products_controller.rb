class ProductsController < ApplicationController
  def create
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.post(
      "#{REST_SERVER_URI}/product/add",
      {
        name: params[:product][:name]
      }.to_json,
      {'Authorization' => "Basic #{auth}", "Content-Type" => "application/json"}
    )

    if HTTP::Status.successful? rq.status
      redirect_to show_path, notice: "New product '#{params[:product][:name]}' has been successfully added."
    else
      redirect_to show_path, notice: "Your product was not added. Please check again."
    end
  end

  def destroy
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.delete(
      "#{REST_SERVER_URI}/product/remove/#{params[:name]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      redirect_to show_path, notice: "Product '#{params[:name]}' has been successfully deleted."
    else
      redirect_to show_path, notice: "Your product was not deleted. Please check again."
    end
  end

  def live
    gon.productname = params[:name]
  end

  def history
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.get(
      "#{REST_SERVER_URI}/product/get/#{params[:name]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      gon.items = content["scores"].map {|x| {x: DateTime.strptime("#{x["date"]}", "%Q").iso8601, y: x["score"], label: score2emoticon(x["score"].to_f)}}
      p gon.items
    else
      gon.items = []
    end

  end

  def add_data_point2
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.get(
      "#{REST_SERVER_URI}/product/getAverage/#{params[:name]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      response = {x: Time.now, y: content["average"]}
      p response
      send_data(response.to_json, :status => 200, :type => "application/json")
    else

    end
  end

  def add_data_point
    now = Time.now
    url = "#{REST_SERVER_URI}/product/scores/#{params[:name]}/#{params[:from]}000/#{now.to_i}000"
    p url
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.get(
      url,
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      sum = 0.0
      content.map{|x| sum += x["score"]}
      response = {x: now, y: sum / content.size, from: now.to_i}
      p response
      send_data(response.to_json, :status => 200, :type => "application/json")
    else

    end
  end

  private

  def score2emoticon(score)
    className =
      if score < 1
        "emoticon1"
      elsif score < 2
        "emoticon2"
      elsif score < 3
        "emoticon3"
      else
        "emoticon4"
      end
    return {
      content: "test",
      className: className
    }
  end
end
