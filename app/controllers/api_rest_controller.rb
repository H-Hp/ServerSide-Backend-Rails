class ApiRestController < ApplicationController
  protect_from_forgery #これはCSRF(Cross-Site Request Forgery）の対策
  #CRUD・create、Read、update、deleteのシステム

=begin
  $costomers=[
    { id:1, name:"田中", password:"aaa" },
    { id:2, name:"山田", password:"bbb"},
    { id:3, name:"上田", password:"ccc"},
    { id:4, name:"山上", password:"ddd"},
  ]
=end

  #データを取得・GETメソッド
  #http://127.0.0.1:3000/api_rest
  def index
    @costomers = Costomer.all
    render json: @costomers
  end

  #データを取得・GETメソッド
  #http://127.0.0.1:3000/api_rest/1
  def show
    @costomers = Costomer.all
    # パラメータで受け取ったidに一致する顧客を探す
    #@selected_costomer = @costomers.find { |costomer| costomer[:id] == params[:id].to_i }
    # URLから取得したIDを使用して顧客を検索
    # params[:id]はURLの最後の数字（この例では1）を取得
    @selected_costomer = @costomers.find { |costomer| costomer[:id] == params[:id].to_i }
   
    # 見つからない場合はnilになります
    if @selected_costomer
      # 顧客が見つかった場合の処理
      render json: @selected_costomer
    else
      # 顧客が見つからない場合
      render json: { error: "Customer not found" }, status: :not_found
    end
  end

  #データを送信・POSTメソッド
  def create
    @costomer = Costomer.new(costomer_params)
    if @costomer.save
      render json: @costomer, status: :created
    else
      render json: @costomer.errors, status: :unprocessable_entity
    end
  end

  #データ更新・PUTメソッド
  def update
    @costomer = Costomer.find(params[:id])
    if @costomer.update(costomer_params)
      render json: @costomer
    else
      render json: @costomer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @costomer = Costomer.find(params[:id])
    @costomer.destroy
    head :no_content
  end

  private

  def costomer_params
    params.require(:costomer).permit(:name, :password)
  end



end
