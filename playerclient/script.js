/*
var myvar = document.getElementById("mydiv");
var mybutton = document.getElementById("bluebutton");
var i = 0;
var myarray = [];

function myfunct()
{
    //myvar.innerHTML = "other value";
    var newelement = document.createElement("p");
    newelement.innerHTML = "new paragraph";
    newelement.setAttribute("id", "par" + i);
    i++;
    myarray.push(newelement);
    myvar.appendChild(newelement);
    //alert(myvar);
}

function click()
{
    for (var j = 0; j < myarray.length; j++)
    {
        myarray[j].setAttribute("style", "background-color:blue;");
    }    
}

mybutton.onclick = click;
myvar.onclick = myfunct;
//alert(myvar);
*/

var mycolor = "#000000";
function getObject(data)
{
    mycolor = data.color;
    alert(data.color);
}

window.onload = function(){
var canvas = $("#mycanvas").get()[0];
var ctx = canvas.getContext("2d");
ctx.rect(20, 20, 100, 100);
ctx.stroke();

var s = 0;


function clicky()
{
    if (s == 0) {
    ctx.clearRect(0, 0, 150, 150);
    ctx.fillStyle = mycolor;
    ctx.fillRect(20, 20, 100, 100);
        s = 1;
    }
    else
    {
        ctx.clearRect(0, 0, 150, 150);
    ctx.fillStyle = "#00FF00";
    ctx.fillRect(20, 20, 100, 100);
        s = 0;
    }
}

canvas.onclick = clicky;

var script = document.createElement("script");
script.setAttribute("src", "http://lucidbard.com/myobj.json");
script.setAttribute("type", "text/javascript");

document.getElementsByTagName("head")[0].appendChild(script);


}
//click(function() {
//    alert("hi");});
