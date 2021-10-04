class NameAndCountriesController < ApplicationController
  def guess
    start_benchmark

    countries = UsersIndex.search_country_by_name(search_params[:name])
    valid_countries = []
    countries.each do |country|
      guessed_country = CountriesIndex.search_country_code(country)
      next if guessed_country.blank?

      valid_countries << guessed_country
    end
    
    countries_code = valid_countries.map{|c| c['code'] }.uniq

    finish_benchmark

    render json: {
      guessed_country: countries_code,
      requested_name: search_params[:name],
      time_processed: @execution_time
    }, status: :ok
  end

  private
  
  def search_params
    params.permit(:name)
  end
end