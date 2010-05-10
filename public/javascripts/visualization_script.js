var test_data=''
function visualize_docs_timeline(ngram,data,ngram_index,doc_id){
  doc_id = 0
  test_data = data;
  
  //includes duplicates
  all_corpus_ids = pv.blend(pv.values(test_data)).map(function(x){return x.document.corpus_id})
  //distincts
  distinct_corpora  = pv.dict(all_corpus_ids,function(x){return true})
  
  max_y = pv.max(pv.values(data).map(function(d){return d.length}))
  min_year = pv.min(pv.keys(data).filter(function(y){return y!=1900}))
  var diff = 2010 - min_year;
  min_year = diff < 10 ? 2000 :min_year
  var bar_height = max_y < 50 ? 12 : (max_y < 200 )? 8 : 4;
  var w = 600; var h = max_y*(bar_height+1) + 10;
  min_height = pv.keys(distinct_corpora).length * 25
  
  h = h < min_height? min_height : h

  var years = pv.range(min_year-1,2011);
  var x = pv.Scale.linear(years[0],years[years.length-1]).range(0,w)
  //var x = pv.Scale.ordinal(years).splitBanded(0,w,9/10)
  var y = pv.Scale.linear(0,max_y).range(5,h)
  var color_index = pv.Colors.category20().range().map(function(d){return d.color});
  years_in_data = pv.keys(data).map(function(x){return parseInt(x)});

  var vis = new pv.Panel().width(w+250).height(h).left(15).top(20).fillStyle('#fff')
    .def("i",-1).bottom(15).right(25).canvas('ngram_'+ngram_index);
 
  var timeline_panel = vis.add(pv.Panel).width(w).left(0);
  var legends_panel = vis.add(pv.Panel).width(200).right(0).fillStyle('#e5e5e5');

  var panels = timeline_panel.add(pv.Panel)
    .data(years_in_data)
    .left(function(d){return x(d)-15})
    .width(30)
    .add(pv.Bar)
      .data(function(){return data[this.parent.data()]})
      .width(30).height(bar_height)
      .fillStyle(function(d){return color_index[d.document.corpus_id]})
      .bottom(function(){return this.sibling()? this.sibling().bottom + bar_height + 1 : 0})
      .strokeStyle(function(d){return vis.i()==d.document.id ? 'black':'#fff'})
      //Actions
      .title(function(d){return d.document.title})
      .event("mouseover", function(d){return vis.i(d.document.id)})
      .event("mouseout",function(d){return vis.i(-1)})
      .event("click", function(d){get_document_context(ngram,ngram_index,d.document.id)});
  
  //panels.anchor().add(pv.Label).top(4).text(function(d){return this.parent.data().length})
  //X axis ruler
  timeline_panel.add(pv.Rule)
    .data(years)
    .left(function(d){return x(d)})
    .height(3).bottom(0)
    .anchor("bottom").add(pv.Label)
      .textMargin(5)
      .text(function(d) {return d});

  //Legends
  legends_panel.add(pv.Bar)
    .data(pv.keys(distinct_corpora))
    .width(20).height(15).left(4)
    .top(function(){return this.sibling()? this.sibling().top + 20 : 5})
    .fillStyle(function(d){console.log(d); return color_index[d]})
    .anchor('left').add(pv.Label)
      .left(26)
      .text(function(d){ return corpus_map[d][1]});

  vis.render(); 
}



//The treemap
function render_treemap(data){
  var corpora_data = data;
  var re = '';
  var color = pv.Colors.category19().by(function(n) {return n.keys.slice(0, -1)});
  /* Root panel. */
  var vis = new pv.Panel()
    .width(800)
    .height(500).canvas("corpora_map");

  /* Treemap! */
  vis.add(pv.Bar)
    .extend(pv.Layout.treemap(corpora_data))
    .width(function(n) {return n.width - 1})
    .height(function(n) {return n.height - 1})
    .fillStyle(function(n) {return color(n).alpha(n.keys.join(".").match(re) ? 1 : .2)})
    .title(function(n) {return n.keys.join("-")+ ": " + n.data})
    .cursor("pointer")
    .event("click", function(n) {return top.location= "/corpora/" + n.keys[1]});
    //.anchor("center").add(pv.Label)
    //.textStyle(function() {return "rgba(0,0,0," + this.fillStyle().opacity + ")"});
    //.text(function(n) {return n.keys[n.keys.length - 1]});

  vis.render();
}

