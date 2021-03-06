require 'nokogiri'
require 'open-uri'

# get '/:fund' do
#   @fund = params[:fund]
#   @text_input = @fund
#   @fund_url = ("http://www.finance.yahoo.com/q?s=" + text_input)

#   @doc = Nokogiri::HTML(open(fund_url))
#   @name = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.rtq_div').css('.yui-g').css('.yfi_rt_quote_summary').css('h2').text
#   @price = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.rtq_div').css('.yui-g').css('.yfi_rt_quote_summary').css('.yfi_rt_quote_summary_rt_top.sigfig_promo_1').css('.time_rtq_ticker').text.to_f
#   @morningstar_rating = doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_fund_basics').css('.bd').css('table').css('tr').css('td').css('.yfnc_tabledata1.yfi_morning_star_rating').to_s[73]
#   @crunched = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.first.yfi-start-content').css('.yfi_quote_summary').css('.rtq_table').css('table').css('tr').css('td:nth-child(2)').text
#   @expanded = @crunched.split("")
#   @ytd_return = @expanded[5..9].join("").to_f
#   @div_yield = @expanded[-5..-1].join("").to_f
#   @top_holdings = []
#   @fund_basics = []
#   @performance_and_risk_stage = []

#   @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_fund_basics').css('.bd').css('table').css('td').each do |i|
#     @fund_basics << i.text
#   end

#   @total_assets = fund_basics[3]
#   @category = fund_basics[4]
#   @expense_ratio = fund_basics[5]

#   @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_top_holdings').css('.bd').css('table').css('td').css('.name').each do |equity|
#     @top_holdings << equity.text
#   end

#   @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_perf_risk').css('.bd').css('table').css('td').each do |i|
#     @performance_and_risk_stage << i.text
#   end

#   @five_yr_return = performance_and_risk_stage[3]
#   @rank_in_category = performance_and_risk_stage[5]
#   @percent_rank_in_category = performance_and_risk_stage[7]
#   @three_yr_beta = performance_and_risk_stage[9]
#   @morningstar_risk_rating = performance_and_risk_stage[11]

#   @description = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_business_summary').css('.bd').text[0..-10]

#   erb :mutf_summary
# end

get '/' do
 erb :index
end

post '/mutf_summary' do
  @fund = params[:fund]
  @fund_url = ("http://www.finance.yahoo.com/q?s=" + @fund)
  @doc = Nokogiri::HTML(open(@fund_url))
  @name = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.rtq_div').css('.yui-g').css('.yfi_rt_quote_summary').css('h2').text
  @price = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.rtq_div').css('.yui-g').css('.yfi_rt_quote_summary').css('.yfi_rt_quote_summary_rt_top.sigfig_promo_1').css('.time_rtq_ticker').text.to_f
  @morningstar_rating = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_fund_basics').css('.bd').css('table').css('tr').css('td').css('.yfnc_tabledata1.yfi_morning_star_rating').to_s[73]

  @crunched = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.first.yfi-start-content').css('.yfi_quote_summary').css('.rtq_table').css('table').css('tr').css('td:nth-child(2)').text
  @expanded = @crunched.split("")
  @ytd_return = @expanded[5..9].join("").to_f
  @div_yield = @expanded[-5..-1].join("").to_f
  @top_holdings = []
  @fund_basics = []
  @performance_and_risk_stage = []

  @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_fund_basics').css('.bd').css('table').css('td').each do |i|
    @fund_basics << i.text
  end

  @total_assets = @fund_basics[3]
  @category = @fund_basics[4]
  @expense_ratio = @fund_basics[5]

  @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_top_holdings').css('.bd').css('table').css('td').css('.name').each do |equity|
    @top_holdings << equity.text
  end

  @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_perf_risk').css('.bd').css('table').css('td').each do |i|
    @performance_and_risk_stage << i.text
  end

  @five_yr_return = @performance_and_risk_stage[3]
  @rank_in_category = @performance_and_risk_stage[5]
  @percent_rank_in_category = @performance_and_risk_stage[7]
  @three_yr_beta = @performance_and_risk_stage[9]
  @morningstar_risk_rating = @performance_and_risk_stage[11]

  @description = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_business_summary').css('.bd').text[0..-10]

  @new_fund = Fund.create(morningstar_rating: "#{@morningstar_rating}", name: "#{@name}", category: "#{@category}", description: "#{@description}", price: "#{@price}", expense_ratio: "#{@expense_ratio}", div_yield: "#{@div_yield}", ytd_return: "#{@ytd_return}", five_yr_return: "#{@five_yr_return}", total_assets: "#{@total_assets}", three_yr_beta: "#{@three_yr_beta}", rank_in_category: "#{@rank_in_category}", percent_rank_in_category: "#{@percent_rank_in_category}")

  erb :mutf_summary
end

get '/all' do
  @all = Fund.all
  erb :all
end

get '/users/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  @user = User.create(username: params[:username], password: params[:password])
  erb :user_summary
end

post '/user_mutf_summary' do
  @fund = params[:fund]
  @fund_url = ("http://www.finance.yahoo.com/q?s=" + @fund)
  @doc = Nokogiri::HTML(open(@fund_url))
  @name = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.rtq_div').css('.yui-g').css('.yfi_rt_quote_summary').css('h2').text
  @price = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.rtq_div').css('.yui-g').css('.yfi_rt_quote_summary').css('.yfi_rt_quote_summary_rt_top.sigfig_promo_1').css('.time_rtq_ticker').text.to_f
  @morningstar_rating = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_fund_basics').css('.bd').css('table').css('tr').css('td').css('.yfnc_tabledata1.yfi_morning_star_rating').to_s[73]

  @crunched = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.first.yfi-start-content').css('.yfi_quote_summary').css('.rtq_table').css('table').css('tr').css('td:nth-child(2)').text
  @expanded = @crunched.split("")
  @ytd_return = @expanded[5..9].join("").to_f
  @div_yield = @expanded[-5..-1].join("").to_f
  @top_holdings = []
  @fund_basics = []
  @performance_and_risk_stage = []

  @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_fund_basics').css('.bd').css('table').css('td').each do |i|
    @fund_basics << i.text
  end

  @total_assets = @fund_basics[3]
  @category = @fund_basics[4]
  @expense_ratio = @fund_basics[5]

  @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_top_holdings').css('.bd').css('table').css('td').css('.name').each do |equity|
    @top_holdings << equity.text
  end

  @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_perf_risk').css('.bd').css('table').css('td').each do |i|
    @performance_and_risk_stage << i.text
  end

  @five_yr_return = @performance_and_risk_stage[3]
  @rank_in_category = @performance_and_risk_stage[5]
  @percent_rank_in_category = @performance_and_risk_stage[7]
  @three_yr_beta = @performance_and_risk_stage[9]
  @morningstar_risk_rating = @performance_and_risk_stage[11]

  @description = @doc.css('body').css('div#yfi_doc').css('div#yfi_bd').css('div#yfi_investing_content').css('.yui-u.rr').css('div#yfi_business_summary').css('.bd').text[0..-10]

  @new_fund = Fund.create(morningstar_rating: "#{@morningstar_rating}", name: "#{@name}", category: "#{@category}", description: "#{@description}", price: "#{@price}", expense_ratio: "#{@expense_ratio}", div_yield: "#{@div_yield}", ytd_return: "#{@ytd_return}", five_yr_return: "#{@five_yr_return}", total_assets: "#{@total_assets}", three_yr_beta: "#{@three_yr_beta}", rank_in_category: "#{@rank_in_category}", percent_rank_in_category: "#{@percent_rank_in_category}")

  @user.funds << @new_fund

  erb :mutf_summary
end

get '/login.erb' do
  erb :login
end
