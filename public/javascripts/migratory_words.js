var loaded_ngram = [];
var loaded_doc_id = {};
var loaded_docs = {};

function main(response){
  console.log(response)
}

//UTILITIES
function show_treemap(disk_size){
   $.getJSON('corpora/get_corpora_stat?disk_size=' + disk_size, function(data) {
    render_treemap(data);
    });
}

//Ngram docs request

function show_details(elem,ngram_index){
  // console.log("index in show_details = " + ngram_index )
  var ngram =$(elem).text();
  $('#ngram_'+ngram_index).parent().toggle();
  
  if ($.inArray(ngram_index, loaded_ngram) < 0) {
    $('#ngram_'+ngram_index).text('loading...');
    $.getJSON('/documents/get_docs_by_ngram?ngram='+ngram, function (result) {
      if(!result['error']){
        console.log(result);
        loaded_ngram.push(ngram_index);
        loaded_doc_id[ngram_index] = pv.blend(pv.values(result.documents).map(function(x){return x.map(function(d){return d.document.id})}));
        loaded_docs[ngram_index] = result.documents;
        visualize_docs_timeline(ngram,result['documents'],ngram_index);
        }
    });
  }
}

function get_document_context(ngram,ngram_index,doc_id){
  if ($('#docs_'+ngram_index).children().size() == 0) {
    $.getJSON('/documents/get_docs_with_context?ngram='+ngram+'&doc_id='+loaded_doc_id[ngram_index].join(','), function (data) {
      construct_doc_table(data,ngram,ngram_index,doc_id);
    });
  } else {
    $('#docs_'+ngram_index+' tbody tr').css('background-color', 'transparent');
    $('#context_row_'+doc_id).css('background-color', 'black');
  }
}

function construct_doc_table(docs,ngram,ngram_index,selected_doc_id){
  var div_id = 'docs_'+ngram_index
  $("#"+div_id).append('<table cellspacing="0" cellpadding="2" border="1"><thead><tr><td>Document</td></tr></thead><tbody></tbody></table>');
  $.each(loaded_doc_id[ngram_index], function  () {
    var tdi = $(this)[0];   // temp_doc_id
    if (tdi == selected_doc_id) $('#'+div_id+' table tbody').append('<tr id="context_row_'+tdi+'" onclick="visualize_docs_timeline(\''+ngram+'\', loaded_docs['+ngram_index+'], '+ngram_index+', '+tdi+')" style="background-color:black;"><td>'+tdi+docs[tdi].leftcontent+docs[tdi].ngram+docs[tdi].rightcontent+'</td></tr>');
    else $('#'+div_id+' table tbody').append('<tr id="context_row_'+tdi+'" onclick="visualize_docs_timeline(\''+ngram+'\', loaded_docs['+ngram_index+'], '+ngram_index+', '+tdi+')"><td>'+tdi+docs[tdi].leftcontent+docs[tdi].ngram+docs[tdi].rightcontent+'</td></tr>');
  })
}

function highlight_doc (doc_id) {
  visualize_docs_timeline(ngram,data,ngram_index,doc_id);
}


function add_to_favorite(params){
  console.log(params)
  $.post("/favorite_ngrams/create", params,
    function(data){    
    });
}


///////////// The corpus map ///////////////

var corpus_map = {1:["aei", "American Enterprise Institute"], 2:["brookings", "Brookings Institute"], 3:["cfr", "Council on Foreign Relations"], 4:["civitas", "John W. Pope Civitas Institute"], 5:["bills", "Bills and Resolutions"], 6:["cato", "Cato Institute"], 7:["fraser", "Fraser Institute"], 8:["hearings", "Congressional Hearings"], 9:["nber", "National Bureau of Economic Research"], 10:["ncpa", "National Center for Policy Analysis"], 11:["rand", "The Rand Corporation"], 12:["cgdev", "Center for Global Development"], 13:["prnewswire", "PR Newswire"], 14:["reports", "Congressional Reports"], 15:["urban", "Urban Institute"], 16:["thehill", "The Hill Position Papers Database"], 17:["presidential", "Presidential Documents"], 18:["cr", "Congressional records"], 19:["fr", "Federal Register"], 20:["ltw", "LA and Washington Post"], 21:["nyt", "NewYork Times"], 22:["xin", "Xinhua"], 23:["afp", "Agence France Presse"], 24:["apw", "AP newswire"], 25:["cna", "Central News Agency, Taiwan"]} 
