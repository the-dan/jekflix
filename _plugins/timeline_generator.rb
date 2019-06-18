require 'jekyll/document'
require 'json'
require 'rubygems'



module Jekyll
	
	class Jekyll::Document
		attr_accessor :name
		
		def path_to_source
			File.join(*[@name].compact)
		end
		
		def location_on_server(my_url)
			"#{my_url}#{url}"
		end
	end
	
	class TimelineFile < StaticFile
		def write(dest)
			true
		end
	end

	class TimelineGenerator < Generator
		priority :lowest
		
		TIMELINE_TEMPLATE = "timeline.md"
		TIMELINE_FILENAME = "timeline.html"
		
		def generate(site)
			timeline_config = site.config['timeline'] || {}
			@config = {}
			@config['template'] = timeline_config['template'] || TIMELINE_TEMPLATE
			@config['filename'] = timeline_config['filename'] || TIMELINE_FILENAME
			
			timeline = site.pages.detect { |page| page.name == 'timeline.md' }
			
			posts = site.posts.docs.map {
				|p|
				
				p.data['description'] = p.data['introduction']
				if p.data['description'] == nil or p.data['description'].strip == ""
					p.data['description'] = p.data['excerpt']
				end
				p.data["category"] = "post"
				p.data['link'] = p.data['url']
				p.data
			}

			items = JSON.parse(File.read("items.json"))
			items = items.map {
				|i| 

				if i["date"].nil? or i["date"].strip == "" then
					i["date"] = Time.now
				else
					i["date"] = Time.parse(i["date"])
				end
				i
			}

			events = posts + items

			events = events.map { |e|
				if e.has_key? "image" and (e["image"].nil? or e["image"].empty?)
					e["image"] = nil
				end
				e
			}

			puts "Total #{events.size} events gathered"

			events.sort! { |a,b|
				if a['date'] > b['date'] then
					-1
				else
					1
				end
			}

			timeline.data['events'] = events
		end

	end
end

