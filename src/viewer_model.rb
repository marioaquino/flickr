require 'flickraw'

class ViewerModel
  attr_accessor :search_terms, :search_results
  
  def initialize
    @search_terms = ''
    @search_results = []
  end
  
  def search
    unless @search_terms.empty?
      @search_results.clear
      @search_results = flickr.photos.search(:text => @search_terms)
    end
  end
  
  def find_sizes_by_id(id)
    flickr.photos.getSizes(:photo_id => id)
  end
end

class FlickRaw::Response
 def to_s
   return title if respond_to? :title
   label
 end
end