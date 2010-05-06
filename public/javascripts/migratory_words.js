function main(response){
  console.log(response)
}

//UTILITIES


//VISUALIZATON SCRIPTS
$(document).ready(function(){
    $.ajax({
        url: 'corpora/get_corpora_stat',
        success: function(data) {
        render_treemap(data);
    }
});

});
//Treemap generation

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



