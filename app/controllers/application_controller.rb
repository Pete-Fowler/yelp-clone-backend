class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  post '/review/' do
    new_review = Review.create(
      user_id: params[:user_id],
      business_id: params[:business_id],
      star_rating: params[:star_rating]
    )
      new_review.to_json
  end
  

  patch '/review/:id' do
    patch_review = Review.find(params[:id])
    patch_review.update(
      star_rating: params[:star_rating]
    )
    patch_review.to_json
  end

  delete '/review/:id' do
    delete_review = Review.find(params[:id])
    delete_review.destroy
    delete_review.to_json
  end

end
