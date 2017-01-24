$(document).ready(function(){

var size = prompt("How many pixels per side on the grid?");
var _size = 960/size;

function addPixel(id) {
	$( "p" ).append($("<div class='block' id=" + id + "></div>"));
}

for ( var i = 0; i < (size * size); i ++) {
	addPixel(i);
}

$("div").css({ width:_size, height:_size });

function col() {
	return 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
}

$(".block").mouseover(function () {
    $(this).css("background-color", col() );
    });
});
