require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

class AlchemyAPI

	#Setup the endpoints
	@@ENDPOINTS = {}
	@@ENDPOINTS['sentiment'] = {}
	@@ENDPOINTS['sentiment']['url'] = '/url/URLGetTextSentiment'
	@@ENDPOINTS['sentiment']['text'] = '/text/TextGetTextSentiment'
	@@ENDPOINTS['sentiment']['html'] = '/html/HTMLGetTextSentiment'
	@@ENDPOINTS['sentiment_targeted'] = {}
	@@ENDPOINTS['sentiment_targeted']['url'] = '/url/URLGetTargetedSentiment'
	@@ENDPOINTS['sentiment_targeted']['text'] = '/text/TextGetTargetedSentiment'
	@@ENDPOINTS['sentiment_targeted']['html'] = '/html/HTMLGetTargetedSentiment'
	@@ENDPOINTS['author'] = {}
	@@ENDPOINTS['author']['url'] = '/url/URLGetAuthor'
	@@ENDPOINTS['author']['html'] = '/html/HTMLGetAuthor'
	@@ENDPOINTS['keywords'] = {}
	@@ENDPOINTS['keywords']['url'] = '/url/URLGetRankedKeywords'
	@@ENDPOINTS['keywords']['text'] = '/text/TextGetRankedKeywords'
	@@ENDPOINTS['keywords']['html'] = '/html/HTMLGetRankedKeywords'
	@@ENDPOINTS['concepts'] = {}
	@@ENDPOINTS['concepts']['url'] = '/url/URLGetRankedConcepts'
	@@ENDPOINTS['concepts']['text'] = '/text/TextGetRankedConcepts'
	@@ENDPOINTS['concepts']['html'] = '/html/HTMLGetRankedConcepts'
	@@ENDPOINTS['entities'] = {}
	@@ENDPOINTS['entities']['url'] = '/url/URLGetRankedNamedEntities'
	@@ENDPOINTS['entities']['text'] = '/text/TextGetRankedNamedEntities'
	@@ENDPOINTS['entities']['html'] = '/html/HTMLGetRankedNamedEntities'
	@@ENDPOINTS['category'] = {}
	@@ENDPOINTS['category']['url']  = '/url/URLGetCategory'
	@@ENDPOINTS['category']['text'] = '/text/TextGetCategory'
	@@ENDPOINTS['category']['html'] = '/html/HTMLGetCategory'
	@@ENDPOINTS['relations'] = {}
	@@ENDPOINTS['relations']['url']  = '/url/URLGetRelations'
	@@ENDPOINTS['relations']['text'] = '/text/TextGetRelations'
	@@ENDPOINTS['relations']['html'] = '/html/HTMLGetRelations'
	@@ENDPOINTS['language'] = {}
	@@ENDPOINTS['language']['url']  = '/url/URLGetLanguage'
	@@ENDPOINTS['language']['text'] = '/text/TextGetLanguage'
	@@ENDPOINTS['language']['html'] = '/html/HTMLGetLanguage'
	@@ENDPOINTS['text'] = {}
	@@ENDPOINTS['text']['url']  = '/url/URLGetText'
	@@ENDPOINTS['text']['html'] = '/html/HTMLGetText'
	@@ENDPOINTS['text_raw'] = {}
	@@ENDPOINTS['text_raw']['url']  = '/url/URLGetRawText'
	@@ENDPOINTS['text_raw']['html'] = '/html/HTMLGetRawText'
	@@ENDPOINTS['title'] = {}
	@@ENDPOINTS['title']['url']  = '/url/URLGetTitle'
	@@ENDPOINTS['title']['html'] = '/html/HTMLGetTitle'
	@@ENDPOINTS['feeds'] = {}
	@@ENDPOINTS['feeds']['url']  = '/url/URLGetFeedLinks'
	@@ENDPOINTS['feeds']['html'] = '/html/HTMLGetFeedLinks'
	@@ENDPOINTS['microformats'] = {}
	@@ENDPOINTS['microformats']['url']  = '/url/URLGetMicroformatData'
	@@ENDPOINTS['microformats']['html'] = '/html/HTMLGetMicroformatData'
	@@ENDPOINTS['taxonomy'] = {}
	@@ENDPOINTS['taxonomy']['url']  = '/url/URLGetRankedTaxonomy'
	@@ENDPOINTS['taxonomy']['text'] = '/text/TextGetRankedTaxonomy'
	@@ENDPOINTS['taxonomy']['html'] = '/html/HTMLGetRankedTaxonomy'
	@@ENDPOINTS['combined'] = {}
	@@ENDPOINTS['combined']['url'] = '/url/URLGetCombinedData'
	@@ENDPOINTS['combined']['text'] = '/text/TextGetCombinedData'
	@@ENDPOINTS['image_extract'] = {}
	@@ENDPOINTS['image_extract']['url'] = '/url/URLGetImage'
	@@ENDPOINTS['image_tag'] = {}
	@@ENDPOINTS['image_tag']['url'] = '/url/URLGetRankedImageKeywords'
	@@ENDPOINTS['image_tag']['image'] = '/image/ImageGetRankedImageKeywords'

	@@BASE_URL = 'http://access.alchemyapi.com/calls'

	def initialize()
		begin
			key = ENV['ALCHEMYAPI_KEY']
			@apiKey = key
		end
	end

	def sentiment(flavor, data, options = {})
		unless @@ENDPOINTS['sentiment'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'sentiment analysis for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['sentiment'][flavor], options)
	end


	def keywords(flavor, data, options = {})
		unless @@ENDPOINTS['keywords'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'keyword extraction for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['keywords'][flavor], options)
	end

	private

	# HTTP Request wrapper that is called by the endpoint functions. This function is not intended to be called through an external interface.
	# It makes the call, then converts the returned JSON string into a Ruby object.
	#
	# INPUT:
	# url -> the full URI encoded url
	#
	# OUTPUT:
	# The response, already converted from JSON to a Ruby object.
	#
	def analyze(url, options)

		#Insert the base URL
		url = @@BASE_URL + url

		#Add the API key and set the output mode to JSON
		options['apikey'] = @apiKey
		options['outputMode'] = 'json'

		uri = URI.parse(url)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data(options)

		# disable gzip encoding which blows up in Zlib due to Ruby 2.0 bug
		# otherwise you'll get Zlib::BufError: buffer error
		request['Accept-Encoding'] = 'identity'

		#Fire off the HTTP request
		res = Net::HTTP.start(uri.host, uri.port) do |http|
      		http.request(request)
    	end

		#parse and return the response
		return JSON.parse(res.body)
	end
end
