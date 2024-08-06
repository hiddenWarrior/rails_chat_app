class CachedModel < ApplicationRecord
    self.abstract_class = true
  
    def cache_object(key)
        str = JSON.generate(self.attributes)
        puts "hi"
        puts str
        Rails.cache.write(key, str ,:expires_in => 99999)

    end
    def self.load_cache(key)
        js_str = Rails.cache.read(key)
        if js_str == nil
            nil
        else
            attrs = JSON.parse(js_str)
            self.new(**JSON.parse(js_str))
        end
    end

    def delete_cache(key)
        puts "hi from delete"
        js_str = Rails.cache.delete(key)
        puts js_str
        js_str

    end

    def self.delete_cache(key)
        puts "hi from delete"
        js_str = Rails.cache.delete(key)
        puts js_str
        js_str
    end


end
