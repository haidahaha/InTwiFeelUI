class ProductsController < ApplicationController
  def create
    client = HTTPClient.new
    auth = Base64.strict_encode64("#{session[:username]}:#{session[:password]}")
    rq = client.post(
      "http://127.0.0.1:8080/product/add",
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
      "http://127.0.0.1:8080/product/remove/#{params[:name]}",
      {},
      {'Authorization' => "Basic #{auth}"}
    )

    p rq

    if HTTP::Status.successful? rq.status
      redirect_to show_path, notice: "Product '#{params[:name]}' has been successfully deleted."
    else
      redirect_to show_path, notice: "Your product was not deleted. Please check again."
    end
  end
end
