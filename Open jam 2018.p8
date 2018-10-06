pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

--
-- standard pico-8 workflow
--

function _init()
    player = {x = 64, y = 64, spd = 1, dir = false}
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
    local new_x = player.x
    local new_y = player.y
    -- apply controls
    if btn(0) then
        player.dir = true
        new_x -= player.spd
    elseif btn(1) then
        player.dir = false
        new_x += player.spd
    end

    if btn(2) then
        new_y -= player.spd
    elseif btn(3) then
        new_y += player.spd
    end
    -- test collisions
    if not wall_area(new_x, player.y, 2, 2) then
        player.x = new_x -- new_x is OK!
    end
    if not wall_area(player.x, new_y, 2, 2) then
        player.y = new_y -- new_y is OK!
    end
end

function wall(x,y)
    local m = mget(x/8,y/8)
    if ((x%8<4) and (y%8<4)) return fget(m,0)
    if ((x%8>=4) and (y%8<4)) return fget(m,1)
    if ((x%8<4) and (y%8>=4)) return fget(m,2)
    if ((x%8>=4) and (y%8>=4)) return fget(m,3)
    return true
end

function wall_area(x,y,w,h)
    return wall(x-w,y-h) or wall(x-1+w,y-h) or
           wall(x-w,y-1+h) or wall(x-1+w,y-1+h)
end

--
-- drawing
--

function draw_world()
    cls(0)
    map(0, 0, 0, 0, 16, 16)
end

function draw_player()
    spr(1, player.x - 4, player.y - 6)
end
__gfx__
00000000000000007777777777770000000077770000000000000000777777770000000000007777777700007777000000007777777777777777777777770000
00000000000000007777777777770000000077770000000000000000777777770000000000007777777700007777000000007777777777777777777777770000
00000000000000007777777777770000000077770000000000000000777777770000000000007777777700007777000000007777777777777777777777770000
00000000000000007777777777770000000077770000000000000000777777770000000000007777777700007777000000007777777777777777777777770000
00000000008888007777777700000000000000007777000000007777000000007777777700007777777700007777777777777777000077777777000000007777
00000000008888007777777700000000000000007777000000007777000000007777777700007777777700007777777777777777000077777777000000007777
00000000008888007777777700000000000000007777000000007777000000007777777700007777777700007777777777777777000077777777000000007777
00000000008888007777777700000000000000007777000000007777000000007777777700007777777700007777777777777777000077777777000000007777
00007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
000f0f01020408030c0a050d0e0b070906000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000070707070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000008080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000900000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000900000a000e0000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000900000a00000c000b00000202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000a0a000000000e000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000a0b080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000b08080808000b000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000008080c000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000009000a000900000f0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000e001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
