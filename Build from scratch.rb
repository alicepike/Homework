
class sentenceUi
	def initialize(sentence_store,io)
		@store = sentence_store
		@io = io
	end
	def main_request
		@io.puts("Welcome to sentence master, would you like to 
			create and store (s) a sentence, retrieve (r) a sentence or list (l) all existing sentences?")

		answer = gets().chomp().downcase()

		if answer == "s"
			puts("Sentence Name")
			sentence_name = gets().chomp()

			puts("Sentence Content")
			sentence_content = gets().chomp()

			sentence = Sentence.new(sentence_name,sentence_content)
			@store.add(sentence)

			puts("The sentence #{sentence.name()} has been stored!")

		elsif answer == "r" 
			puts("Sentence Name")
			sentence_name = gets().chomp()

			unless Sentence.retrieve(sentence_name)
				abort("Sorry, this sentence does not exist!")
			end
		end
	end
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
