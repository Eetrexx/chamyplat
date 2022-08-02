


function love.load()
  Object = require "classic"
  require "entity"
  
  image = love.graphics.newImage("Free/Main Characters/Mask Dude/Idle (32x32).png")
  walk_image = love.graphics.newImage("Free/Main Characters/Mask Dude/Run (32x32).png")
  jump_image = love.graphics.newImage("Free/Main Characters/Mask Dude/Jump (32x32).png") 
  fall_image = love.graphics.newImage("Free/Main Characters/Mask Dude/Fall (32x32).png") 
  double_jump_image = love.graphics.newImage("Free/Main Characters/Mask Dude/Double Jump (32x32).png") 
  
  background_image = love.graphics.newImage("Free/Background/Pink.png") 

  walk_frames = {}
  frames = {}
  double_jump_frames = {}
  
  jump_frame = {}
  fall_frame = {}

  image_width = image:getWidth()
  image_height = image:getHeight()
  local frame_width = 32 
  local frame_height = 32
  max_collunms = math.floor(image_width / frame_width)

  walk_width = walk_image:getWidth() 
  walk_height = walk_image:getHeight()

  double_jump_width = double_jump_image:getWidth()

  walk_collunmns = math.floor(walk_width / frame_width)

  double_jump_cols = math.floor(double_jump_width / frame_width)

  double_jump = false

  ground = 400
  player_x = 100
  player_y = ground 

  y_velocity = 0

  player_jump_height = -300
  player_gravity = -500

  jump_fall_col = 1

  face = 1

  curr_img = image
  curr_frames = frames
  curr_col = max_collunms

  
  for i=0,max_collunms-1 do 
    table.insert(frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, image_width, image_height))
  end

  for i=0,walk_collunmns-1 do
    table.insert(walk_frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, walk_width, walk_height))
  end

  for i=0,double_jump_cols do
    table.insert(double_jump_frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, double_jump_width, frame_height))
  end

  table.insert(jump_frame, love.graphics.newQuad(0, 0, frame_width, frame_height, frame_width, frame_height))
  table.insert(fall_frame, love.graphics.newQuad(0, 0, frame_width, frame_height, frame_width, frame_height))
  currentFrame = 1

end


function love.draw()
  for i=0,love.graphics.getWidth(),64 do
    for j=0,love.graphics.getHeight(),64 do 
      love.graphics.draw(background_image, i, j)
    end
  end
  love.graphics.draw(curr_img, curr_frames[math.floor(currentFrame)], player_x, player_y, 0, face, 1)
end

function love.keypressed(key)

  if key == "space" then
    if y_velocity == 0 then
      y_velocity = player_jump_height
    elseif double_jump == false then
      double_jump = true
      y_velocity = player_jump_height
    end
  end
end
function love.update(dt)

  if love.keyboard.isDown("right") then
    if face == -1 then
      player_x = player_x - 32 * 1 
    end
    if player_x < (love.graphics.getWidth() - 32) then
      
      player_x = player_x + 200 * dt
    end
    face = 1
    if y_velocity == 0 then
      
      curr_img = walk_image
      curr_frames = walk_frames
      curr_col = walk_collunmns
    elseif y_velocity < 0 then
      if double_jump == true then
        curr_img = double_jump_image
        curr_frames = double_jump_frames
        curr_col = double_jump_cols
      else
        curr_img = jump_image
        curr_frames = jump_frame
        curr_col = jump_fall_col
      end
    else
      curr_img = fall_image
      curr_frames = fall_frame
      curr_col = jump_fall_col
    end
    
  elseif love.keyboard.isDown("left") then

    if face == 1 then
      player_x = player_x + 32 * 1 
    end

    if player_x > 32 then
      
      player_x = player_x - 200 * dt
    end
    face = -1
    if y_velocity == 0 then
      curr_img = walk_image
      curr_frames = walk_frames
      curr_col = walk_collunmns
    elseif y_velocity < 0 then
      if double_jump == true then
        curr_img = double_jump_image
        curr_frames = double_jump_frames
        curr_col = double_jump_cols
      else
        curr_img = jump_image
        curr_frames = jump_frame
        curr_col = jump_fall_col
      end
    else
      curr_img = fall_image
      curr_frames = fall_frame
      curr_col = jump_fall_col
    end
  else
    if y_velocity == 0 then
      curr_img = image
      curr_frames = frames
      curr_col = max_collunms
    elseif y_velocity < 0 then
      curr_img = jump_image
      curr_frames = jump_frame
      curr_col = jump_fall_col
    else
      curr_img = fall_image
      curr_frames = fall_frame
      curr_col = jump_fall_col
    end
  end
--[[
  if love.keyboard.isDown("space") then
    if y_velocity == 0 then
      y_velocity = player_jump_height
    elseif double_jump == false then
      double_jump = true
      y_velocity = player_jump_height
    end
  end
--]]
  if y_velocity ~= 0 then
    player_y = player_y + y_velocity * dt
    y_velocity = y_velocity - player_gravity * dt
  end

  if player_y > ground then
    y_velocity = 0
    player_y = ground
    double_jump = false
  end

  currentFrame = currentFrame + 10 * dt
  if currentFrame > curr_col then
    currentFrame = 1
  end
end

