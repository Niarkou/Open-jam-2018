pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

--
-- standard pico-8 workflow
--

function _init()
    player = {x = 64, y = 64}
end

function _update()
    update_player()
end

function _draw()
    draw_world()
    draw_player()
end

--
-- play
--

function update_player()
    if btn(0) then
        player.x -= 1
    elseif btn(1) then
        player.x += 1
    end
end

--
-- drawing
--

function draw_world()
    cls(0)
end

function draw_player()
    spr(1, player.x, player.y)
end
__gfx__
00000000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
