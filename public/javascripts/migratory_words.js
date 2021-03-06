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
        loaded_ngram.push(ngram_index);
        loaded_doc_id[ngram_index] = pv.blend(pv.values(result.documents).map(function(x){return x.map(function(d){return d.document.id})}));
        loaded_docs[ngram_index] = result.documents;
        visualize_docs_timeline(ngram,result.documents,ngram_index,0,0);
        }
    });
  }
}


function get_document_context(ngram,ngram_index,doc_id,page){
  var total_num_docs = loaded_doc_id[ngram_index].length;
  var total_pages = Math.floor(total_num_docs/rpp) + 1;
  if (doc_id != 0) {
    var current_doc_index = -1;
    $.each(loaded_doc_id[ngram_index], function  (i, v) {
      if (doc_id == v) {
        current_doc_index = i;
        return false;
      }
    });
    page = Math.floor(current_doc_index/rpp) + 1;
  }
  var chunked_doc_ids = loaded_doc_id[ngram_index].slice((page-1)*rpp, page*rpp);
  if ($('#docs_'+ngram_index+' table#context_'+page).length == 0) {
    $('#ajax-loader-'+ngram_index).show();
    $.getJSON('/documents/get_docs_with_context?ngram='+ngram+'&doc_id='+chunked_doc_ids.join(','), function (data) {
      construct_doc_table(data,ngram,ngram_index,doc_id,page,total_pages);
      $('#ajax-loader-'+ngram_index).hide();
    });
  } else {
    show_doc_table(ngram_index,page,doc_id);
  }
}

function construct_doc_table(docs,ngram,ngram_index,selected_doc_id,page,total_pages){
  var div_id = 'docs_'+ngram_index;
  var options = '';
  for (var i=1;i<=total_pages;i++) {
    if (i == page) options += '<option value="'+i+'" selected="selected">'+i+'</option>';
    else options += '<option value="'+i+'">'+i+'</option>';
  }
  if (rpp > 1) {
    var thead = '<thead><tr><td>Page '+page+' / Go to page <select onchange="get_document_context(\''+$.trim(ngram)+'\','+ngram_index+',0,this.value);">'+options+'</select></td></tr></thead>';
  } else {
    var thead = '';
  }
  $("#"+div_id).append('<table id="context_'+page+'">'+thead+'<tbody></tbody></table>');
  $.each(loaded_doc_id[ngram_index].slice((page-1)*rpp, page*rpp), function(){
    var tdi = $(this)[0];   // temp_doc_id
    if (tdi == selected_doc_id) var row_class = 'active';
    else var row_class = 'inactive';
    $('#'+div_id+' table#context_'+page+' tbody').append('<tr id="context_row_'+tdi+'" onclick="visualize_docs_timeline(\''+ngram+'\', loaded_docs['+ngram_index+'], '+ngram_index+', '+tdi+')" class="'+row_class+'"><td><h5 style="margin:0px;"><a href="'+docs[tdi].trackback_url+'">'+docs[tdi].title+'</a> | <span>'+docs[tdi].corpus+' ('+docs[tdi].published_time.replace(/T.*/g, '')+')</span></h5>'+docs[tdi].leftcontent+'<span class="hlgt">'+docs[tdi].ngram+'</span>'+docs[tdi].rightcontent+'</td></tr>');
    // else $('#'+div_id+' table#context_'+page+' tbody').append('<tr id="context_row_'+tdi+'" onclick="visualize_docs_timeline(\''+ngram+'\', loaded_docs['+ngram_index+'], '+ngram_index+', '+tdi+')" class="inactive"><td>'+docs[tdi].leftcontent+'<span class="hlgt">'+docs[tdi].ngram+'</span>'+docs[tdi].rightcontent+'</td></tr>');
  });
  show_doc_table(ngram_index,page,selected_doc_id);
}

function show_doc_table (ngram_index,page,doc_id) {
  var dn = '#docs_'+ngram_index;
  $(dn+' tbody tr').css('background-color', 'transparent').css('color', '#222');
  $(dn+' tbody tr span.hlgt').css('color', 'black');
  $(dn+' tbody tr h5 a').css('color', '#414a8a');
  if (rpp > 1) {
    $(dn+' #context_row_'+doc_id).css('background-color', 'maroon').css('color', '#DDD');
    $(dn+' #context_row_'+doc_id+' span.hlgt').css('color', 'white');
    $(dn+' #context_row_'+doc_id+' h5 a').css('color', 'white');
  }
  $(dn+' table').hide();
  $(dn+' table#context_'+page).show();
}


function highlight_doc (doc_id) {
  visualize_docs_timeline(ngram,data,ngram_index,doc_id);
}

function add_to_favorite(elem,params){
  console.log(elem)
  $.post("/favorite_ngrams/create", params,
    function(data){    
    console.log(elem.parent());
    });
}


///////////// The corpus map ///////////////

var corpus_map = {1:["aei", "American Enterprise Institute"], 2:["brookings", "Brookings Institute"], 3:["cfr", "Council on Foreign Relations"], 4:["civitas", "John W. Pope Civitas Institute"], 5:["bills", "Bills and Resolutions"], 6:["cato", "Cato Institute"], 7:["fraser", "Fraser Institute"], 8:["hearings", "Congressional Hearings"], 9:["nber", "National Bureau of Economic Research"], 10:["ncpa", "National Center for Policy Analysis"], 11:["rand", "The Rand Corporation"], 12:["cgdev", "Center for Global Development"], 13:["prnewswire", "PR Newswire"], 14:["reports", "Congressional Reports"], 15:["urban", "Urban Institute"], 16:["thehill", "The Hill Position Papers Database"], 17:["presidential", "Presidential Documents"], 18:["cr", "Congressional records"], 19:["fr", "Federal Register"], 20:["ltw", "LA and Washington Post"], 21:["nyt", "NewYork Times"], 22:["xin", "Xinhua"], 23:["afp", "Agence France Presse"], 24:["apw", "AP newswire"], 25:["cna", "Central News Agency, Taiwan"]} 
