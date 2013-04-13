
class sentenceUi
end

class sentenceStore
	def initialize()
	end

	def save(sentence)
		file = File.open( ,"w+")
		file.write(sentence)
		file.close()
		return true
	end

	def find_by_name(name)
		to_open = file_name(name)

		unless File.exist?(to_open)
			return false
		end

		file = File.open(to_open,"r")
		content = file.read()
		file.close()

		sentence = Sentence.new(name,content)

		return sentence
	end

	def all()
		all_text_files = Dir.glob("*.txt")
		all_sentences = []
		all_text_files.map do |file_name|
			name = file_name.gsub(".txt","")
			all_sentences.push(find_by_name(name))
		end

		return all_sentences
	end

	private

	def file_name(name)
		return name + ".txt"
	end
end

class Sentence

	attr_reader "name", "content"

	def initialize(name,content)
		@name = name
		@content = content
	end
	def name(new_content)
		@content = new_content
	end
end