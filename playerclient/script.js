var outerRadius = 120;
var innerRadius = 20;
var colorGreen = '#00FF00';
var colorBlue = '#0000FF';
var colorRed = '#FF0000';
var colorBlack = '#000000';
var colorDarkGreen = '#006633';
var colorWhite = '#FFFFFF';

window.onload = function() {
// =================== [ Kinetic Stuff ] =====================    
var stage = new Kinetic.Stage({
    container: 'container',
    width: 959,
    height: 821
});

var sCenterX = stage.getWidth() / 2;
var sCenterY = stage.getHeight() / 2;

// ---------------Text------------------
var topText = new Kinetic.Text({
    x: 10,
    y: 0,
    fontSize: 24,
    fontFamily: 'Calibri',
    text: 'Click on object to select it.\nClick and hold an object to bring up the radial menu.\nClick on background to deselct the object.\nIn radial menu, click and select a wedge.\nClick and hold on the center circle to confirm selection.',
    fill: colorGreen
});
/*
topText.setOffset({
    x: topText.getWidth() / 2
});
*/

// ---------------Layers-----------------
var backgroundLayer = new Kinetic.Layer();
var actionableLayer = new Kinetic.Layer();
var menuLayer = new Kinetic.Layer();

backgroundLayer.add(new Kinetic.Rect({
    x: 0,
    y: 0,
    width: stage.getWidth(),
    height: stage.getHeight(),
    id: 'background'
}));
backgroundLayer.on('tap click', function () {
    var items = actionableLayer.getChildren();
    for (var item in items) {
        items[item].setFill(colorBlue);
        items[item].name = 'inactive';
        items[item].setShadowColor(colorBlack);
        items[item].setShadowOffset(5);
        items[item].setShadowBlur(15);
    }
    isPressHold = false;
    infoBox.setVisible(false);
    radialMenu.setVisible(false);

    actionableLayer.draw();
    menuLayer.draw();
    stage.draw();
});
backgroundLayer.add(topText);
stage.add(backgroundLayer);

// ------------------Radial Menu------------------
// Radial Menu Group
var radialMenu = new Kinetic.Group({
    x: 0,
    y: 0,
    draggable: false,
    visible: false,
    id: 'RadialMenu'
});
// Outer bounding circle
var outerCircle = new Kinetic.Circle({
    x: 0,
    y: 0,
    radius: outerRadius,
    opacity: 0.1,
    fill: colorGreen,
    shadowColor: colorBlack,
    shadowBlur: 20,
    shadowOffset: 10,
    stroke: colorBlack,
    strokeWidth: 4
});
// Circle wedges
var numWedges = 4;
for (var i = 0; i < numWedges; i++) {
    var wedge = new Kinetic.Wedge({
        x: 0,
        y: 0,
        radius: outerRadius,
        angle: Math.PI / 2,
        opacity: 0.5,
        fill: colorBlue,
        stroke: colorBlack,
        strokeWidth: 4,
        rotation: -(2 * (i + 1) - 1) * Math.PI / 4,
        id: i,
        name: 'wedge',
    });
    radialMenu.add(wedge);
}
var wedges = radialMenu.get('.wedge');
for (var i = 0; i < wedges.length; i++) {
    // TAP to select INTENT    
    wedges[i].on('tap click', function () {
        // Need to set this up so it recognizes which wedge is selected and deselect the rest
        for (var j = 0; j < wedges.length; j++) {
            wedges[j].setFill(colorBlue);
        }
        this.setFill(colorRed);
        // Update center circle info with highlighted (TAP) selection
        centerCircle.setFill(colorRed);
        centerCircle.setName('active');
        menuLayer.draw();
    });
}
var centerCircle = new Kinetic.Circle({
    x: 0,
    y: 0,
    radius: innerRadius * 2,
    opacity: 1.0,
    fill: colorDarkGreen,
    stroke: colorBlack,
    strokeWidth: 3,
    draggable: false,
    name: 'nonactive'
});
// TAP & HOLD center circle to CONFIRM selection
//    Store selection/decision/entity
var timer;
var isHold = false;
centerCircle.on('mousedown mouseup', function (event) {
    // While there is a selection made
    if (this.getName() == 'active') {
        if (event.type != 'mouseup') {
            timer = setTimeout(function () {
			// Confirm selection
                var items = actionableLayer.getChildren();
                for (var item in items) {
                    items[item].setFill(colorBlue);
                    items[item].name = 'inactive';
                    items[item].setShadowColor(colorBlack);
                    items[item].setShadowOffset(5);
                    items[item].setShadowBlur(15);
                }
                isHold = false;
                infoBox.setVisible(false);
                radialMenu.setVisible(false);

                actionableLayer.draw();
                menuLayer.draw();
            }, 650);
        } else {
            // Reset timeout
            clearTimeout(timer);
            this.setName('nonactive');
            isHold = false;
        }
    }
});
radialMenu.add(centerCircle);
// -----------------End Radial Menu--------------------

// -------------------Info Text-------------------------
var infoBox = new Kinetic.Label({
    x: 0,
    y: 0,
    opacity: 0.8,
    name: 'infoBox',
    visible: false,
    text: {
        text: 'Entity: room object\nStatus: active\nPickup: yes',
        fontFamily: 'Calibri',
        fontSize: 18,
        padding: 5,
        fill: '#FFFFFF'
    },
    rect: {
        fill: colorBlack,
        pointerDirection: 'left',
        pointerWidth: 10,
        pointerHeight: 10,
        lineJoin: 'round',
        shadowColor: colorBlack,
        shadowBlur: 10,
        shadowOffset: 10,
        shadowOpacity: 0.5
    }
});
menuLayer.add(infoBox);
menuLayer.add(radialMenu);

// ---------------Image-------------------
/* Notes: Can't seem to make loading images and having them be
			clickable work.
*/
// Image Loader
/*
function loadImages(sources, callback) {
    var images = {};
    var loadedImages = 0;
    var numImages = 0;
    // Get the total number of souce images to load
    for (var i in sources) {
        numImages++;
    }
    for (var src in sources) {
        images[src] = new Image();
        images[src].onload = function () {
            if (++loadedImages >= numImages) {
                callback(images);
            }
        };
        images[src].src = sources[src];
    }
}

function drawImages(images) {
    /*
    var skel = new Kinetic.Image({
        image: images.char1,
        x: 50,
        y: 100,
        width: 150,
        height: 300,
        name: 'inactive'
    });

    var pic = new Kinetic.Rect({
        x: 50,
        y: 100,
        width: 150,
        height: 300,
        name: 'inactive',
        id: 'pic'
        fillPatternImage: images.char1,
        fillPatternScale: {
            x: 0.45,
            y: 0.65
        }
    });
    actionableLayer.add(pic);
    actionableLayer.draw();
}
var imageSources = {
    char1: 'https://raw.github.com/lucidbard/ludicbard/master/MismanorLib/src/img/stableboy2.png?login=Arcainne&token=64e376f0910b13bc5cafd1d0ba0923e5'
};
loadImages(imageSources, drawImages);
*/

/*
actionableLayer.get('#pic').on('click', function() {
    this.setFill(colorRed);
var items = actionableLayer.getChildren();
    for (var item in items) {
        items[item].setFill(colorRed);
        items[item].name = 'inactive';
        actionableLayer.draw()
    }
isPressHold = false;
    infoBox.setVisible(false);
    radialMenu.setVisible(false);
    actionableLayer.draw();
    menuLayer.draw();
    stage.draw();
});
*/

// -----------------Actionables----------------------
// Have list of actionable items/entities
//     Each have a property for determining if it is highlighted
//        or not (bool)
/*
var entities = new Array();
var numEntities = 5;
for (var i = 0; i < numEntities; i++) {
    // Populate entities array
    // Create Entity object
    function entity() {
        this.state = 0;
    }
}
*/

// 3 Test polygons to test interaction----------------------------------
var item1 = new Kinetic.RegularPolygon({
    x: 250,
    y: 200,
    sides: 4,
    radius: 30,
    fill: colorBlue,
    shadowColor: colorBlack,
    shadowBlur: 15,
    shadowOffset: 5,
    stroke: colorBlack,
    strokeWidth: 4,
    name: 'inactive'
});
actionableLayer.add(item1);

var item2 = new Kinetic.RegularPolygon({
    x: 250,
    y: 300,
    sides: 5,
    radius: 30,
    fill: colorBlue,
    shadowColor: colorBlack,
    shadowBlur: 15,
    shadowOffset: 5,
    stroke: colorBlack,
    strokeWidth: 4,
    name: 'inactive'
});
actionableLayer.add(item2);

var item3 = new Kinetic.RegularPolygon({
    x: 250,
    y: 400,
    sides: 6,
    radius: 30,
    fill: colorBlue,
    shadowColor: colorBlack,
    shadowBlur: 15,
    shadowOffset: 5,
    stroke: colorBlack,
    strokeWidth: 4,
    name: 'inactive'
});
actionableLayer.add(item3);
// ----------------------------------------------------------------

/*
var items = actionableLayer.getChildren();
    for (var item in items) {
        //items[item].on('mousedown', function() {
        items[item].setFill(colorRed);
        items[item].name = 'inactive';
        actionableLayer.draw();
        stage.draw();
       // });
    }
*/

// Cycle through every actionable entity and apply interaction
var children = actionableLayer.getChildren();
for (var j = 0; j < children.length; j++) {
    // Press and hold function
    // Note:  Currently not working with touch controls
	//			(i.e. changing the inputs to 'touchstart' and 'touchend' respectively)
    var pressTimer;
    var isPressHold = false;
    var tempChild = children[j].clone();

    // ACTIVATE selected item by TAP & HOLD (~0.5sec // need deltaTime)
    children[j].on('mousedown mouseup', function (event) {
        var touchPos = stage.getPointerPosition();

        // Allow radial menu to appear while mouse is down
        if (event.type != 'mouseup') {
            // Make press & hold timer for menu
            //if (this.name == 'active') {
            pressTimer = setTimeout(function () {
                // Once hold time has passed...
                isPressHold = true;

                // Reset all other objects
                for (var i = 0; i < children.length; i++) {
                    children[i].setFill(colorBlue);
                    children[i].name = 'inactive';
                    children[i].setShadowColor(colorBlack);
                    children[i].setShadowOffset(5);
                    children[i].setShadowBlur(15);
                }
                //children[j].setFill(colorRed);

                // Reset all wedges' color
                var sections = radialMenu.get('.wedge');
                for (var i = 0; i < sections.length; i++) {
                    sections[i].setFill(colorBlue);
                }
                centerCircle.setFill(colorDarkGreen);

                // Display radial menu centered at TAP POSITION
                infoBox.setVisible(false);
                radialMenu.setVisible(true);
                radialMenu.setPosition(touchPos);

                actionableLayer.draw();
                menuLayer.draw();
            }, 650);
            //}
        } else {
            // Reset timeout
            clearTimeout(pressTimer);

            // Allow user to SELECT item by TAPPING
            if (!isPressHold) {
                // Displays side info (text box relative to TAP POSITION)
                for (var i = 0; i < children.length; i++) {
                    children[i].setFill(colorBlue);
                    children[i].name = 'inactive';
                    children[i].setShadowColor(colorBlack);
                    children[i].setShadowOffset(5);
                    children[i].setShadowBlur(15);
                }
                this.name = 'active';
                this.setFill(colorGreen);
                this.setShadowColor(colorWhite);
                this.setShadowOffset(0);
                this.setShadowBlur(20);

                infoBox.setPosition(touchPos);
                infoBox.setVisible(true);

                actionableLayer.draw();
                menuLayer.draw();
            }
            isPressHold = false;
        }
    });
}

stage.add(actionableLayer);
stage.add(menuLayer);
}