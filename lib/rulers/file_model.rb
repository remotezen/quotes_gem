require "multi_json"
require "json"
module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i
        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end
      
      def [](name)
        @hash[name.to_s]
      end
      
      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.find(id)
        begin
         FileModel.new("db/quotes/#{id}.json")
        rescue
          return nil
        end

      end
      def self.submitter(string)
        files = Dir["db/quotes/*.json"]
        string = string.gsub(/\r/," ")
        string = string.gsub(/\n/," ")
        arr = Array.new
        files.each do |f| 
          obj = FileModel.new(f)
          h = obj.hash
          s = String.new(h["submitter"])
          if string == s 
            arr << h
          end
        end
          STDERR.puts(arr.inspect)
          arr
      end

      def hash
        @hash
      end
    
      def self.all
        files = Dir["db/quotes/*.json"]
        files.map {|f| FileModel.new f}
      end      
      def update(attrs)
        @hash.merge!(attrs)
        File.open(@filename, "w") do |f|
          f.write(hash.to_json)
        end
      end
      
      def self.create(attrs)
        hash = {}
        hash["submitter"] = attrs["submitter"] || ""
        hash["quote"] = attrs["quote"] || ""
        hash["attribution"] = attrs["attribution"] || ""
        files = Dir["db/quotes/*json"]
        names = files.map {|f| f.split("/")[-1]}
        highest = names.map {|b| b[0...-5].to_i }.max
        id  = highest + 1
         h = {
          "submitter" => hash["submitter"],
          "quote" => hash["quote"],
          "attribution" =>  hash["attribution"]
          }
        File.open("db/quotes/#{id}.json", "w") do |f|
          f.write(h.to_json)
        end
        FileModel.new "db/quotes/#{id}.json"
      end
    end
  end
end
  
