img = new Image();
img.src = "/images/sprites/tanks.png";

var WATER = 1;
var BRICK = 2;
var STONE = 3;
var TREE = 4;
var LATTICE = 5;
var ROAD = 6;
var TANK = 7;
var FLAG = 8;
var ENEMY_TANK = 9;
var map = [
[6, 6, 4, 4, 6, 6, 6, 6, 6, 6, 4, 4, 4, 6, 6, 6],
[6, 6, 4, 4, 6, 6, 2, 6, 2, 6, 4, 4, 6, 5, 5, 6],
[6, 2, 4, 6, 6, 2, 2, 6, 2, 6, 4, 4, 6, 5, 5, 6],
[6, 2, 4, 3, 6, 9, 2, 6, 2, 6, 4, 4, 6, 5, 5, 6],
[6, 2, 4, 3, 6, 6, 2, 6, 2, 6, 4, 4, 6, 6, 6, 6],
[1, 2, 2, 4, 3, 6, 2, 6, 2, 6, 4, 4, 9, 5, 5, 6],
[1, 1, 1, 1, 6, 6, 2, 6, 2, 6, 4, 4, 6, 5, 5, 6],
[1, 1, 1, 1, 6, 3, 2, 2, 2, 6, 4, 4, 6, 1, 1, 6],
[1, 1, 1, 1, 6, 6, 2, 6, 2, 6, 6, 6, 6, 5, 1, 6],
[3, 3, 3, 4, 6, 6, 2, 6, 2, 6, 2, 2, 6, 5, 1, 6],
[3, 6, 6, 2, 6, 6, 2, 6, 2, 6, 2, 2, 6, 5, 5, 6],
[3, 6, 6, 2, 6, 6, 2, 6, 2, 6, 1, 1, 6, 2, 2, 6],
[3, 3, 3, 4, 6, 6, 2, 6, 2, 6, 1, 1, 6, 2, 4, 6],
[1, 1, 1, 1, 6, 6, 2, 6, 2, 6, 2, 2, 6, 2, 4, 6],
[2, 2, 2, 2, 6, 6, 2, 2, 2, 6, 6, 6, 6, 2, 4, 6],
[2, 2, 2, 2, 6, 6, 2, 8, 2, 6, 6, 6, 6, 2, 2, 6]
];

img.onload = function () {
  context.scale(2, 2);

  for(var i = 0; i < map.length; i++) {
    for(var j = 0; j < map[i].length; j++) {
     switch(map[i][j]) {
      case WATER:
        var water = new Water(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(water);
      break;
      case BRICK:
        var brick = new Brick(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(brick);
      break;
      case STONE:
        var stone = new Stone(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(stone);
      break;
      case TREE:
        var tree = new Tree(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(tree);
      break;
      case LATTICE:
        var lattice = new Lattice(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(lattice);
      break;
      case ROAD:
        var road = new Road(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(road);
      break;
      case FLAG:
        var flag = new Flag(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(flag);
      break;
      case ENEMY_TANK:
        var enemy_tank = new Enemy_Tank(j * TILE_SIZE, i * TILE_SIZE);
        mapObject.push(enemy_tank)
      break;
    }
  }
}
};

function stone(x, y) {
  context.save();
  context.translate(x, y);
  context.drawImage(img, 109, 414, 8, 8, 0, 0, 8, 8);
  context.drawImage(img, 109, 414, 8, 8, 8, 0, 8, 8);
  context.drawImage(img, 109, 414, 8, 8, 0, 8, 8, 8);
  context.drawImage(img, 109, 414, 8, 8, 8, 8, 8, 8);
  context.restore();
};

function water(x, y) {
  context.save();
  context.translate(x, y);
  context.drawImage(img, 109, 423, 8, 8 , 0, 0, 8, 8);
  context.drawImage(img, 109, 423, 8, 8 , 8, 0, 8, 8);
  context.drawImage(img, 109, 423, 8, 8 , 0, 8, 8, 8);
  context.drawImage(img, 109, 423, 8, 8 , 8, 8, 8, 8);
  context.restore();
}

function brick(x, y) {
  context.save();
  context.translate(x, y);
  context.drawImage(img, 118, 414, 8, 8, 0, 0, 8, 8)
  context.drawImage(img, 118, 414, 8, 8, 8, 0, 8, 8)
  context.drawImage(img, 118, 414, 8, 8, 0, 8, 8, 8)
  context.drawImage(img, 118, 414, 8, 8, 8, 8, 8, 8)
  context.restore();
}

function tree(x, y) {
  context.save();
  context.translate(x, y)
  context.drawImage(img, 135, 423, 8, 8, 0, 0, 8, 8)
  context.drawImage(img, 135, 423, 8, 8, 8, 0, 8, 8)
  context.drawImage(img, 135, 423, 8, 8, 0, 8, 8, 8)
  context.drawImage(img, 135, 423, 8, 8, 8, 8, 8, 8)
  context.restore();
}

function lattice(x, y) {
  context.save();
  context.translate(x, y)
  context.drawImage(img, 145, 423, 8, 8, 0, 0, 8, 8)
  context.drawImage(img, 145, 423, 8, 8, 8, 0, 8, 8)
  context.drawImage(img, 145, 423, 8, 8, 0, 8, 8, 8)
  context.drawImage(img, 145, 423, 8, 8, 8, 8, 8, 8)
  context.restore();
}

function road(x, y) {
  context.save();
  context.translate(x, y)
  context.drawImage(img, 40, 420, 16, 16, 0, 0, 16, 16)
  context.restore();
}

function flag(x, y) {
  context.save();
  context.translate(x, y)
  context.drawImage(img, 186, 369, 16, 16, 0, 0, 16, 16)
  context.restore();
}

function enemy_tank(x, y) {
  context.save();
  context.translate(x, y)
  context.drawImage(img, 142, 349, 16, 16, 0, 0, 16, 16)
  context.restore();
}
