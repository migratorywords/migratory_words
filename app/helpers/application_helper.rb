# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def option_corpus(id)
    # str = '<input type="checkbox" id="'+id+'" name="'+id+'" '
    # if params[id.to_sym] == 'on'
    #   str += 'checked="checked" '
    # end
    # str += '/><label for="'+id+'">'+@corpus_hash[id]+'</label>'
    str = '<option value="'+id+'"'
    if params[:corpus] == id
      str += 'selected="selected" '
    end
    str += '>'+@corpus_hash[id]+'</option>'
    str
  end
end
