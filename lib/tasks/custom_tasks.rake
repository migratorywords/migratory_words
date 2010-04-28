
corpus_location = "/Users/viallon/migratory_words/corpus/"


def loadhash(corpus)
    "hehe"
end

task :import_ngrams => :environment do
    pr_hash = loadhash("prnewswire")
    puts pr_hash
    data_location = corpus_location + "prnewswire/sample_metadata/"
    files=Dir.entries(data_location) - ['.','..','.DS_Store','_meta.txt']     
    files.each do |file_name|
    end
end

task :import_pr_documents => :environment do
    category_hash = {}
    PrCategory.all.each{|c| category_hash[c.name]=c.id}

    data_location = corpus_location + "prnewswire/metadata/"
    files=Dir.entries(data_location) - ['.','..','.DS_Store','_meta.txt']     
    files.each do |file_name|
        puts file_name
        doc_no = file_name.split("_")[0]
        metadata={:author=>"none", :description=>"none", :geo_region=>"none", :geo_place=>"none", :publisher=>"none", :date=>Time.parse("01/01/1990 12:00")}
        File.open(data_location + file_name).each do |line|
            unless line.strip == "##### METADATA #####"
                begin
                    k,v = line.split(':')
                    metadata[k.strip] = v.strip
                rescue
                    puts "some problem in #{file_name} in line : #{line}"
                end
            end
        end
        cats=[]
        if metadata['categories']
           cats = metadata['categories'].split(',').map{|c| category_hash[c.strip]}
           #puts cats
        end
        #puts metadata.keys
        #puts "-----------------------"
        begin
            doc = Document.create(:doc_number=>doc_no, :published_time=>Time.parse(metadata['date']),:corpus=>'prnewswire', :author=>metadata['author'], :geo_region=>metadata['geo_region'], :geo_place=>metadata['geo_place'], :publisher=>metadata['publisher'], :description=>metadata['description'])
            doc.pr_category_ids = cats 
        rescue Exception => e
            puts "--------------- Some problem in #{file_name}"
            puts "\t\t #{e.message}"
        end
    end
end


#Importing all the pr categories in the pr_categories table
task :import_pr_categories => :environment do
    file_name = "#{corpus_location}prnewswire/only_categories.txt"
    File.open(file_name).each do |l|
        cat_num, cat_name = l.split(':')
        PrCategory.create(:pr_number=>cat_num.strip.to_i, :name=>cat_name.strip)
    end
end