
// Globals
var outerRadius = 120;
var innerRadius = 20;
var colorGreen = '#00FF00';
var colorBlue = '#0000FF';
var colorRed = '#FF0000';
var colorBlack = '#000000';

window.onload = function(){
var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');
var centerX = canvas.width / 2;
var centerY = canvas.height / 2;

// =================== [ Kinetic Stuff ] =====================    
var stage = new Kinetic.Stage({
    container: 'container',
    width: 512,
    height: 512
});

var sCenterX = stage.getWidth() / 2;
var sCenterY = stage.getHeight() / 2;

var topText = new Kinetic.Text({
    x: stage.getWidth() / 2,
    y: 0,
    fontSize: 20,
    fontFamily: 'Calibri',
    text: 'Begin Kinetic Lab',
    fill: colorRed
});

topText.setOffset({
    x: topText.getWidth() / 2
});

var backgroundLayer = new Kinetic.Layer();
var menuLayer = new Kinetic.Layer();
var dragLayer = new Kinetic.Layer();

var radialMenu = new Kinetic.Group({
    x: stage.getWidth() / 2,
    y: stage.getHeight() / 2,
    draggable: false
});

var outerCircle = new Kinetic.Circle({
    x: 0,
    y: 0,
    radius: outerRadius,
    opacity: 0.8,
    fill: colorGreen,
    shadowColor: colorBlack,
    shadowBlur: 20,
    shadowOffset: 10,
    stroke: colorBlack,
    strokeWidth: 4
});

// Create Circle Sectors
/*
var numSectors = 4;
for (var i = 0; i < numSectors; i++) {
    // induce scope
    (function () {
        var sector = new Kinetic.Shape({
            drawFunc: function (canvas) {
                //var context = canvas.getContext();
                ctx.beginPath();
                ctx.moveTo(-5, -20);
                ctx.bezierCurveTo(-40, -90, 40, -90, 5, -20);
                ctx.closePath();
                canvas.fillStroke(this);
            },
            opacity: 0.8,
            fill: '#00dddd',
            strokeWidth: 4,
            draggable: false,
            rotation: 2 * Math.PI * i / numSectors
        });

        sector.on('mouseover', function () {
            this.setFill('blue');
            menuLayer.draw();
        });

        sector.on('mouseout', function () {
            this.setFill('#00dddd');
            menuLayer.draw();
        });

        radialMenu.add(sector);
    }());
}
*/

var numWedges = 4;
for (var i = 0; i < numWedges; i++) {
    var wedge = new Kinetic.Wedge({
        x: 0,
        y: 0,
        radius: outerRadius,
        angle: Math.PI / 2,
        fill: colorGreen,
        stroke: colorBlack,
        strokeWidth: 4,
        rotation: (2 * (i + 1) - 1) * Math.PI / 4
    });
    
    wedge.on('mouseover', function() {
        this.setFill(colorRed);
        menuLayer.draw();
    });
    
    wedge.on('mouseout', function() {
        this.setFill(colorGreen);
        menuLayer.draw();
    });
    
    wedge.on('tap', function() {
        this.setFill(colorBlue);
        menuLayer.draw();
    });
    
    radialMenu.add(wedge);
}

var centerCircle = new Kinetic.Circle({
    x: 0,
    y: 0,
    radius: innerRadius * 2,
    fill: '#006633',
    stroke: colorBlack,
    strokeWidth: 2,
    draggable: false
});

var innerCircle = new Kinetic.Circle({
    x: 0,
    y: 0,
    radius: innerRadius,
    fill: colorBlue,
    stroke: colorBlack,
    strokeWidth: 2,
    draggable: true,
    dragBoundFunc: function (pos) {
        var x = stage.getWidth() / 2;
        var y = stage.getHeight() / 2;
        var radius = outerRadius - innerRadius;
        var scale = radius / Math.sqrt(Math.pow(pos.x - x, 2) + Math.pow(pos.y - y, 2));
        // If the object position is out of bounds
        if (scale < 1) return {
            x: Math.round((pos.x - x) * scale + x),
            y: Math.round((pos.y - y) * scale + y)
        };
        else return pos;
    }
});

innerCircle.on('dragstart', function () {
    var mousePos = stage.getMousePosition();
    var x = mousePos.x - stage.getWidth();
    var y = mousePos.y - stage.getHeight();
    this.setFill(colorRed);
    menuLayer.draw();
    /*
    dragLine = new Kinetic.Line({
        strokeWidth: 10,
        stroke: colorRed,
        points: [mousePos.x, mousePos.y, 
                 innerCircle.getX(), innerCircle.getY()]
    });
    */
});

innerCircle.on('dragend', function () {
    this.setFill(colorBlue);
    this.setPosition(0, 0);
    menuLayer.draw();
});

//outerBounds.add(innerCircle);

//dragLayer.add(dragLine);
//radialMenu.add(outerCircle);
radialMenu.add(innerCircle);
//radialMenu.add(outerBounds);

backgroundLayer.add(topText);
menuLayer.add(radialMenu);

stage.add(backgroundLayer);
stage.add(menuLayer);
//stage.add(dragLayer);


// =================== [ Canvas ] ========================
var outerC = {
    x: centerX,
    y: centerY,
    radius: outerRadius,
    sAngle: 0,
    eAngle: 2 * Math.PI,
    counterClock: false,
    fill: colorGreen,
    stroke: colorBlack,
    line: 4
};

var innerC = {
    x: centerX,
    y: centerY,
    radius: innerRadius,
    sAngle: 0,
    eAngle: 2 * Math.PI,
    counterClock: false,
    fill: colorBlue,
    stroke: colorBlack,
    line: 2
};

function createMenu(outerC, innerC, ctx) {
    // Draw outer circle
    ctx.beginPath();
    ctx.arc(outerC.x, outerC.y,
    outerC.radius,
    outerC.sAngle,
    outerC.eAngle,
    outerC.counterClock);
    ctx.fillStyle = outerC.fill;
    ctx.fill();
    ctx.save();
    ctx.shadowColor = colorBlack;
    ctx.shadowBlur = 20;
    ctx.shadowOffsetX = 10;
    ctx.shadowOffsetY = 10;
    ctx.fill();
    ctx.restore();
    ctx.strokeStyle = outerC.stroke;
    ctx.lineWidth = outerC.line;
    ctx.stroke();

    // Draw inner circle
    ctx.beginPath();
    ctx.arc(innerC.x, innerC.y,
    innerC.radius,
    innerC.sAngle,
    innerC.eAngle,
    innerC.counterClock);
    ctx.fillStyle = innerC.fill;
    ctx.fill();
    ctx.strokeStyle = innerC.stroke;
    ctx.lineWidth = innerC.line;
    ctx.stroke();
}

function clickDrag() {
    ctx.fillStyle = colorRed;
}

createMenu(outerC, innerC, ctx);
//canvas.onClick = clickDrag;


ctx.font = "20px Arial";
ctx.fillStyle = colorRed;
ctx.textAlign = "center";
ctx.fillText("End Canvas Lab", centerX, canvas.height - 10);
ctx.beginPath();
ctx.moveTo(0, canvas.height);
ctx.lineTo(canvas.width, canvas.height);
ctx.lineWidth = 5;
ctx.stroke();
}