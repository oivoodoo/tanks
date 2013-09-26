var canvas = document.getElementById("game");
var context = canvas.getContext("2d");
window.requestAnimFrame = (function (callback) {
  return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function (callback) {
    window.setTimeout(callback, 1000 / 60);
  };
})();

var TILE_SIZE = 16;

var WIDTH = map.length * TILE_SIZE * 2 / 2 - 16;
var HEIGHT = map[0].length * TILE_SIZE * 2 / 2 - 16;

canvas.width = map.length * TILE_SIZE * 2; // the width of the playing field
canvas.height = map[0].length * TILE_SIZE * 2; // the height of the playing field

var cx = canvas.width / 3.56,
    cy = canvas.height / 2;





var spriteIndex = 0;
var width = 64;
var height = 64;
var rows = 4;
var cols = 4;

var exp = document.createElement("img");
exp.onload = function () {
  explode();
}
exp.src = "/images/sprites/explode.png";


var fps = 60;
function explode() {
  // are we done? ... if so, we're outta here
  if (spriteIndex > 15) {
      return;
  }

  // It's good practice to use requestAnimation frame
  // We wrap it in setTimeout because we want timed frames
  setTimeout(function () {

      // queue up the next frame
      requestAnimFrame(explode);

      // Draw the current frame
      var x = spriteIndex % (cols - 1) * width;
      var y = parseInt(spriteIndex / (rows - 1)) * height;
      context.drawImage(exp, x, y, width, height, 120, 50, width, height);

      // increment the sprite counter
      spriteIndex++;
  }, 1000 / fps);

}

var Player = function() {
  this.way = 38;
  var context = this;
  window.addEventListener('keydown', function(e) {
    context.way = e.keyCode;
    context.is_moving = true;
  }, false);
  window.addEventListener('keyup', function(e) {
    context.is_moving = false;
  }, false);
};

Player.prototype.update = function() {
  if (this.way == 32) {
    // pressed space button to shoot the enemies
    var bullet = new Bullet(cx, cy);
    bullets.push(bullet);
  } else {
    // else we are moving on the map
    if(this.is_moving) {
      switch (this.way) {
        case 37:
          cx -= 1;
        break;// left
        case 39:
          cx += 1;
        break;// right
        case 38:
          cy -= 1;
        break;// up
        case 40:
          cy += 1;// down
        break;
      }
    }
  }

  if(cx < 0){
    cx = 0
  }else if(cy < 0) {
    cy = 0
  }else if(cx > WIDTH){
    cx = WIDTH;
  }else if(cy > HEIGHT){
    cy = HEIGHT;
  }
};

Player.prototype.draw = function() {
  context.save();
  context.translate(cx, cy);
  switch (this.way) {
    case 37:
      context.drawImage(img, 52, 316, 16, 16, 0, 0, TILE_SIZE, TILE_SIZE);
    break;// left
    case 39:
      context.drawImage(img, 1, 316, 16, 16, 0, 0, TILE_SIZE, TILE_SIZE);
    break;// right
    case 38:
      context.drawImage(img, 36, 316, 16, 16, 0, 0, TILE_SIZE, TILE_SIZE);
    break;// up
    case 40:
      context.drawImage(img, 20, 316, 16, 16, 0, 0, TILE_SIZE, TILE_SIZE);
    break;
  }
  context.restore();
};

var player = new Player();

var Bullet = function(x, y) {
  this.x = x;
  this.y = y;
};

Bullet.prototype.update = function() {
  this.y -= 5;

  if (this.y <= 0) {
    for(var i = 0; i < bullets.length; i++) {
      if (bullets[i] == this) {
        delete bullets[i];
        bullets.splice(i, 1);
        break;
      }
    }
  }
};

Bullet.prototype.draw = function() {
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 162, 377, 4, 4, 5, -5, 4, 4);
  context.restore();
};

var bullets = [];
var mapObject = [];

var Water = function(x, y) {
  this.x = x;
  this.y = y;
};

Water.prototype.update = function() {
};

Water.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 109, 423, 8, 8 , 0, 0, 8, 8);
  context.drawImage(img, 109, 423, 8, 8 , 8, 0, 8, 8);
  context.drawImage(img, 109, 423, 8, 8 , 0, 8, 8, 8);
  context.drawImage(img, 109, 423, 8, 8 , 8, 8, 8, 8);
  context.restore();
};

var Brick = function(x, y) {
  this.x = x;
  this.y = y;
};

Brick.prototype.update = function() {
};

Brick.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 118, 414, 8, 8, 0, 0, 8, 8)
  context.drawImage(img, 118, 414, 8, 8, 8, 0, 8, 8)
  context.drawImage(img, 118, 414, 8, 8, 0, 8, 8, 8)
  context.drawImage(img, 118, 414, 8, 8, 8, 8, 8, 8)
  context.restore();
};

var Stone = function(x, y) {
  this.x = x;
  this.y = y;
};

Stone.prototype.update = function() {
};

Stone.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 109, 414, 8, 8, 0, 0, 8, 8);
  context.drawImage(img, 109, 414, 8, 8, 8, 0, 8, 8);
  context.drawImage(img, 109, 414, 8, 8, 0, 8, 8, 8);
  context.drawImage(img, 109, 414, 8, 8, 8, 8, 8, 8);
  context.restore();
};

var Tree = function(x, y) {
  this.x = x;
  this.y = y;
};

Tree.prototype.update = function() {
};

Tree.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 135, 423, 8, 8, 0, 0, 8, 8);
  context.drawImage(img, 135, 423, 8, 8, 8, 0, 8, 8);
  context.drawImage(img, 135, 423, 8, 8, 0, 8, 8, 8);
  context.drawImage(img, 135, 423, 8, 8, 8, 8, 8, 8);
  context.restore();
};

var Lattice = function(x, y) {
  this.x = x;
  this.y = y;
}

Lattice.prototype.update = function() {
};

Lattice.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 145, 423, 8, 8, 0, 0, 8, 8);
  context.drawImage(img, 145, 423, 8, 8, 8, 0, 8, 8);
  context.drawImage(img, 145, 423, 8, 8, 0, 8, 8, 8);
  context.drawImage(img, 145, 423, 8, 8, 8, 8, 8, 8);
  context.restore();
}

var Road = function(x, y) {
  this.x = x;
  this.y = y;
}

Road.prototype.update = function() {
};

Road.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 40, 420, 16, 16, 0, 0, 16, 16)
  context.restore();
}

var Flag = function(x, y) {
  this.x = x;
  this.y = y;
}

Flag.prototype.update = function() {
};

Flag.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 186, 369, 16, 16, 0, 0, 16, 16)
  context.restore();
}

var Enemy_Tank = function(x, y) {
  this.x = x;
  this.y = y;
}

Enemy_Tank.prototype.update = function() {
};

Enemy_Tank.prototype.draw = function(){
  context.save();
  context.translate(this.x, this.y);
  context.drawImage(img, 142, 349, 16, 16, 0, 0, 16, 16)
  context.restore();
}

var eachFrame = function(callback) {
  setInterval(function() {
    callback.call();
  }, 1000 / 100);
};

eachFrame(function() {
  // zIndex = 0
  for(var i = 0; i < mapObject.length; i++) {
    mapObject[i].update();
    mapObject[i].draw();
  }

  // zIndex = 1
  for(var i = 0; i < bullets.length; i++) {
    var bullet = bullets[i];
    bullet.update();
    bullet.draw();
  }

  // zIndex = 1
  player.update();
  player.draw();
});
