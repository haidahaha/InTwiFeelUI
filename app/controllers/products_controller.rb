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
      emoticon1 = 0
      emoticon2 = 0
      emoticon3 = 0
      emoticon4 = 0
      content["scores"].each do |s|
        score = s["score"].to_i
        if score < 1
          emoticon1 += 1
        elsif score < 2
          emoticon2 += 1
        elsif score < 3
          emoticon3 += 1
        else
          emoticon4 += 1
        end
      end
      gon.emoticon1 = emoticon1
      gon.emoticon2 = emoticon2
      gon.emoticon3 = emoticon3
      gon.emoticon4 = emoticon4
    else
      gon.items = []
    end

  end

  def add_data_point
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.get(
      "#{REST_SERVER_URI}/product/getAverage/#{params[:name]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    if HTTP::Status.successful? rq.status
      content = JSON.parse(rq.content)
      response = {x: Time.now, y: content["average"], label: content["average"].to_f.round(4), tweet: content["example"] || " "}
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
      className: className
    }
  end
end
