pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

--
-- useful functions
--

function jump()
    if btn(2) or btn(5) then
        return true end
end

--
-- standard pico-8 workflow
--

function _init()
    player = {x = 64, y = 64, spd = 0.5, dir = false, jump = 0, grounded = false, spr = 18}
    gravity_speed = 1
end

function _update60()
    update_player()
end

function _draw()
    draw_world()
    draw_player()
    draw_debug()
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

    if player.jump > 0 then
        new_y -= (player.jump / 5) * player.spd
        player.jump -= 1
    else
        new_y += gravity_speed
    end

    if jump() then
        if player.grounded then
            player.jump = 20 -- start jumping
        end
    else
        player.jump = 0 -- stop jumping
    end

    if btn(3) then
        new_y -= player.spd
        if not ladder_area_down(player.x, new_y, 4) then
        player.spr = 26
        end
    else player.spr = 18
    end

    -- test collisions
    if not wall_area(new_x, player.y, 4, 4) or ladder_area_notdown(new_x, new_y, 4, 4) then
        player.x = new_x -- new_x is ok!
    end
    if not wall_area(player.x, new_y, 4, 4) then
        player.grounded = false
        player.y = new_y -- new_y is ok!
    else
        if not jump() then 
            player.grounded = true 
        end
        if btn(3) and ladder_area_down(player.x, new_y, 4) then
            player.y = new_y
        end
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
           wall(x-w,y-1+h) or wall(x-1+w,y-1+h) or
           wall(x-w,y) or wall(x-1+w,y) or
           wall(x,y-1+h) or wall(x,y-h)
end

function ladder(x,y)
    local m = mget(x/8, y/8)
    if not fget(m, 4) then return false
    elseif wall(x,y) then return true
    else return false
    end
end

function ladder_area_down(x,y,h)
    return ladder(x,y+h)
end

function ladder_area_notdown(x,y,w,h)
    return ladder(x-w,y-h) or ladder(x-1+w,y-h) or
           ladder(x-w,y-1+h) or ladder(x-1+w,y-1+h) or
           ladder(x-w,y-h) or ladder(x+w,y-h)
end

--
-- drawing
--

function draw_world()
    cls(0)
    map(0, 0, 0, 0, 16, 16)
end

function draw_player()
    spr(player.spr, player.x - 8, player.y - 12, 2, 2, player.dir)
end

function draw_debug()
    print("player.x  "..player.x, 5, 5, 6)
    print("player.y  "..player.y, 5, 12, 6)
    print("player.jump  "..player.jump, 5, 19, 6)
    print("ladder_down  "..tostr(ladder_area_down(player.x, player.y, 4)), 5, 26, 6)
end
__gfx__
000000000000330077777777777c00000000c7770000000000000000cccccccc000000000000c777777c0000777c00000000c7777777777777777777777c0000
000000000003b63077777777777c00000000c777000000000000000077777777000000000000c777777c0000777c00000000c7777777777777777777777c0000
000000000003bb3077777777777c00000000c777000000000000000077777777000000000000c777777c0000777c00000000c7777777777777777777777c0000
0000000000036b3077777777777c00000000c777000000000000000077777777000000000000c777777c0000777c00000000c7777777777777777777777c0000
00000000003bbb30777777770000000000000000cccc00000000cccc00000000cccccccc0000c777777c0000777cccccccccc7770000c777777c00000000cccc
0000000003bb6b30777777770000000000000000777c00000000c77700000000777777770000c777777c000077777777777777770000c777777c00000000c777
00000000036bb300777777770000000000000000777c00000000c77700000000777777770000c777777c000077777777777777770000c777777c00000000c777
0000000000333000777777770000000000000000777c00000000c77700000000777777770000c777777c000077777777777777770000c777777c00000000c777
0000cccc04ffff40000000003300000000dddddddddddd000000000000000000f880000000000000000000000000000000000000000000000000000000000000
0000c7760400004000000003bb300000dd666666666666dd0000000000000000f8888000a000bb00000000000000000000000000000000000000000000000000
0000c77604ffff400000003bbbb300001dddddddddddddd10000000000000000f8888800ba0b33b0000000000000000000000000000000000000000000000000
0000c666040000400000033bb7b73000111111111111111100087878787880000f888e800bb3373b000000000000000000000000000000000000000000000000
cccc000004ffff400000003bb1b1300011a11aa11a11a1a100878787878788000f88817803333333000000033000000000000000000000000000000000000000
c7760000040000400000003bbbbb30001a1a1a1a1a11aaa10077cccccccc77000f888888310133100000003bb300000000000000000000000000000000000000
c776000004ffff40000003bbbbbb330011a11aa1a1a1a1a107cccccccccccc6000f8888710001100000003bbbb30000000000000000000000000000000000000
c666000004000040000033bbbb113000111a1a11aaa1a1a107cccccccccc6d600007777000000000000003bb7b73000000000000000000000000000000000000
0000000000000000000003bbbbbb30001a1a1a1a11a1a1a107cccccccccc6c60000c000000444400000003bb1b13000000000000000000000000000000000000
000000000000000000003bb3bbbb300011a11a1a11a1a1a107cccccccccc6d60000c000004979740000003bbbbb3000000000000000000000000000000000000
00000000000000000003bb3bb3b30000111111111111111107cccccccccc6c6000cc100047aaaa7400003bbbbbb3300000000000000000000000000000000000
0000000000000000003bbbbbbbb33000111199a9a999111107cccccccccc6d600c7cd100494a4a9400033bbb1113000000000000000000000000000000000000
0000000004ffff40003bbb3bbb300000199a9a9a9a9a999107cccccccccc6c60c7cccd1049aaaa740003bb3bbbb3000000000000000000000000000000000000
0000000004000040003bb3bbbb30000011a9a8888889a91107c6666666666d60c7cccd1049a4aa94003bb3bb3b30000000000000000000000000000000000000
0000000004ffff400003bbbbb3300000199444eefef44991007cdcdcdcdcd6000c7cd10004999740003bbbbbbb30000000000000000000000000000000000000
00000000040000400000333330000000119a9444e9899911000766666666600000dd100000444400000333333300000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003333300000000000000000000000000000000
__gff__
000f0f01020408030c0a050d0e0b0709061f00000f0f0c0c0000000000000000002c00000f0f0f0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0a00000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000006080808050900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000808000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000008210000000000000202000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a19000000110000000000000000180900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e07070700110000000000000e000d0900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000110000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000070714150006080500000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000024251909000000060200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b080500070707070707070000060e0900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0000000000000608080800060e000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00060808050000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b08080808080808080808080808080c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
