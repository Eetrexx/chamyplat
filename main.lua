
function love.load()
  Object = require "classic"
  require "entity"

  image = love.graphics.newImage("Free/Main Characters/Mask Dude/Idle (32x32).png")
  walk_image = love.graphics.newImage("Free/Main Characters/Mask Dude/Run (32x32).png")
  walk_frames = {}
  frames = {}
  image_width = image:getWidth()
  image_height = image:getHeight()
  local frame_width = 32 
  local frame_height = 32
  max_collunms = math.floor(image_width / frame_width)

  walk_width = walk_image:getWidth() 
  walk_height = walk_image:getHeight()

  walk_collunmns = math.floor(walk_width / frame_width)

  player_x = 100
  player_y = 100

  face = 5

  curr_img = image
  curr_frames = frames
  curr_col = max_collunms

  for i=0,max_collunms-1 do 
    table.insert(frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, image_width, image_height))
  end

  for i=0,walk_collunmns-1 do
    table.insert(walk_frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, walk_width, walk_height))
  end
  currentFrame = 1

end

function love.draw()
  love.graphics.draw(curr_img, curr_frames[math.floor(currentFrame)], player_x, player_y, 0, face, 5)
end

function love.update(dt)

  if love.keyboard.isDown("right") then
    player_x = player_x + 200 * dt
    face = 5
    curr_img = walk_image
    curr_frames = walk_frames
    curr_col = walk_collunmns
    
  elseif love.keyboard.isDown("left") then

    player_x = player_x - 200 * dt
    face = -5
    curr_img = walk_image
    curr_frames = walk_frames
    curr_col = walk_collunmns
  else
    curr_img = image
    curr_frames = frames
    curr_col = max_collunms
  end
  currentFrame = currentFrame + 10 * dt
  if currentFrame > curr_col then
    currentFrame = 1
  end
end

