

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  post '/review/' do
    if User.find(params[:user_id]).session_cookie == params[:session_cookie]
      new_review = Review.create(
        user_id: params[:user_id],
        business_id: params[:business_id],
        star_rating: params[:star_rating],
        comment: params[:comment]
      )
      new_review.to_json
    end
  end


  patch '/review/:id' do
    patch_review = Review.find(params[:id])
    if patch_review.user.id == params[:user_id]
      if patch_review.user.session_cookie == params[:session_cookie]
        patch_review.update(
          star_rating: params[:star_rating],
          comment: params[:comment]
        )
        patch_review.to_json
      end
    end
  end

  delete '/review/:id' do
    delete_review = Review.find(params[:id])

        delete_review.destroy
        delete_review.to_json


  end

  # get '/businesses' do
  #   Business.all.to_json
  # end

  get '/business/:id' do
    Business.find(params[:id]).to_json(only: [:name, :address, :business_type, :id, :price, :image_url, :phone_number, :website, :transactions], include:
      { reviews: { only: [:comment, :star_rating, :id, :business_id], include: {
        user: { only: [:username, :profile_picture, :id] }
      } } })
  end

  get '/businesses/search/:term/page/:page' do
    return Business.page(params[:page]).all.to_json(include: :reviews) if params[:term].downcase == 'all'

    biz = Business.page(params[:page]).all.filter do |business|
      business.name.downcase.include?(params[:term].downcase) ||
      business.business_type.downcase.include?(params[:term].downcase) ||
      business.category.downcase.include?(params[:term].downcase)
    end
    biz.to_json(include: :reviews)
  end
end
