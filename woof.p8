pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--mandatory

function _init()
 create_player()
	init_msg()
	create_msg("0","(appuie sur ❎ pour passer\nles messages)","allez babbage, en route pour \nada, c'est mon premier jour !")
end
	

function _update()

 woof()
	var()
	var2()
	
 if not messages[1] then
		player_movement()
	end
	update_msg()
	update_camera()
	flag_down()
	flag_up()
	didacticiel_descendre()
	didacticiel_monter()
	arrivee()
end


function _draw()
 cls()
 draw_map()
 draw_player()
 draw_msg()
end
-->8
--map, camera, check flag

function draw_map()
	map (0,0,0,0,32,16)
end

function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

function update_camera()
 local camx=mid(0,p.x-7.5,31-15)
 camera(camx*8)
end

-->8
--player

function create_player()
 p={x=3,y=4,sprite=1}
end


function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end


function player_movement()
 newx=p.x
 newy=p.y
 
 newx+=0.05
 
 if not check_flag(0,newx+0.95,newy) then
		p.x=newx
		p.y=newy
	end
end


-->8
--messages

function init_msg()
 messages={}
end

function create_msg(name,...)
 msg_title=name
	messages={...}
end

function update_msg()
	if (btnp(❎))then
	deli(messages,1)
	end
end

function draw_msg()
	if messages[1] then
		local y=100
		local x=mid(0,p.x-7.5,16)
		x=x*8
		
		rectfill(x+3,y+8,x+124,y+24,1)
		rect(x+3,y+8,x+124,y+24,6)
		print(messages[1],x+6,y+11,7)
	end
end



--affichage didacticiel

function didacticiel_descendre()
 if check_flag(3,newx,newy) 
 and not deja_vu
 then create_msg("0","n'oublie pas, je ne vois pas\nbien, tu es mon guide !","pour me dire de descendre,\naboie:➡️ ⬇️ ⬆️           (❎)")
 deja_vu=true
 end
end

function didacticiel_monter()
 if check_flag(4,newx,newy)
 and not deja_vu2
 then create_msg("0","pour me dire de monter,\naboie:⬅️ ⬆️ ⬇️           (❎)")
 deja_vu2=true
 end
end


--dialogue de fin

function arrivee()
 if check_flag(5,p.x+1,newy)
 then create_msg("0","on y est,\nmerci babbage !")
 end
end
-->8
--fonctions pour jouer


--flag actions

function flag_down()
 if check_flag(1,newx,newy)
 and not messages[1]
 then descendre()
 end
end

function flag_up()
 if check_flag(2,newx,newy)
 and not messages[1]
 then monter()
 end
end


--aboiements

function woof()
 if (btnp(⬅️)) sfx(3) 
 if (btnp(⬆️)) sfx(2)
 if (btnp(⬇️)) sfx(1)
 if (btnp(➡️)) sfx(0)
end


--fonctions pour commande

-- pour descendre

air=""

--chaines de caracteres descendre
function var()
 if (btnp(⬅️))
  and not messages[1]
  then air=air.."a" end
 if (btnp(⬆️))
  and not messages[1]
  then air=air.."b" end
 if (btnp(⬇️))
  and not messages[1]
  then air=air.."c" end
 if (btnp(➡️))
  and not messages[1]
  then air=air.."d" end
end 



--executer l'action descendre 
function descendre()
 if (air == "dcb")
  then
   down()
 end
 if not (air == sub("dcb",0,#air))
  and not messages[1]
  then air="", create_msg("0","recommence babbage,\nje n'ai pas compris !    (❎)")
	end
end


--fonction qui declare l'action de descendre
function down()
	repeat
		newy+=1
		newx=p.x
	until check_flag(0,newx,newy+1)
		p.x=newx
		p.y=newy
		air=""
		air2=""
end


-- pour monter

air2=""

function var2()
 if (btnp(⬅️))
  and not messages[1]
  then air2=air2.."a" end
 if (btnp(⬆️))
  and not messages[1]
  then air2=air2.."b" end
 if (btnp(⬇️)) 
  and not messages[1]
  then air2=air2.."c" end
 if (btnp(➡️))
  and not messages[1]
  then air2=air2.."d" end
end 

function monter() 
 if (air2 == "abc")
  then
   up()
 end
 if not (air2 == sub("abc",0,#air2))
  and not messages[1] 
  then air2="", create_msg("0","recommence babbage,\nje n'ai pas compris !    (❎)")
 end
end

function up()
	repeat
		newy-=1
		newx=p.x
	until check_flag(0,newx,newy+1)
		p.x=newx
		p.y=newy
		air=""
		air2=""
end



__gfx__
000000000eeeee00eeeee00055555555eeeeeeee66666666577777755dddddd50000000000000000000000000000000000000000000000000000000000000000
000000000f5f5000f5f50000ddddddddfefffffe7677777656666665511111150000000000000000000000000000000000000000000000000000000000000000
000000000ffef000ffef0000fefffffefefffffe767777765dddddd5577777750000000000000000000000000000000000000000000000000000000000000000
000000003333340033330400fefffffefefffffe76777776511111155dddddd50000000000000000000000000000000000000000000000000000000000000000
00000000f3333454f3345400eeeeeeeeeeeeeeee6666666657777775511111150000000000000000000000000000000000000000000000000000000000000000
00000000fc444444fcc44440ffffefffffffefff7777677756666665577777750000000000000000000000000000000000000000000000000000000000000000
0000000004444400c00c0444ffffefffffffefff777767775dddddd55dddddd50000000000000000000000000000000000000000000000000000000000000000
000000000c40c400c00c4444eeeeeeeeeeeeeeee6666666651111115511111150000000000000000000000000000000000000000000000000000000000000000
55555555000000000000000000000000000000006666666600000000000000000000000000000000000000000000000066666666166666660000000000000000
566666650000000000000000000000000000000076777776000000000000000000000000000000000000000000000000767d7776167d77760000000000000000
5dddddd5000000000000000000000000000000007677777600000000000000000000000000000000000000000000000076d1177616d117760000000000000000
5111111500000000000000000000000000000000767777760000000000000000000000000000000000000000000000007d1111761d1111760000000000000000
577777750000000000000000000000000000000066666666000000000000000000000000000000000000000000000000d1111116d11111160000000000000000
5666666500000000000000000000000000000000777767770000000000000000000000000000000000000000000000007aaaaa771aaaaa770000000000000000
5dddddd5000000000000000000000000000000007777677700000000000000000000000000000000000000000000000077111777171117770000000000000000
51111115000000000000000000000000000000006666666600000000000000000000000000000000000000000000000066616666166166660000000000000000
11111111111111111111111111111111111166660000000011111111111111111111111116666666666666666666666666616666166166660000000000000000
17777777777777777777777777777777777177770000000017777777777777777777777717677776717777767677717676717776167177760000000000000000
17117771171111171111171111117111117177770000000017111117117117111711111717677776414444444444414676717776167177760000000000000000
17111711171111171111171111117111117177770000000017111117117117111711111717677776717777767677717676717776767177760000000000000000
17111111171117771111171117117111117166660000000017111777111117111711111716666666414444444444414666616666666166660000000000000000
17111111171111777111771117117117117176770000000017111177711177111771117717777677717767767777617777716777777167770000000000000000
17111111171117777111771111177117117176770000000017111777111117111771117717777677711111111111117777716777777167770000000000000000
17117171171111177111771111117111117166660000000017111117117117111771117716666666616666666666616666616666666166660000000000000000
17117771171111177111771117117111117166660000000017111117117117111771117716666666000000000000000066616666666166660000000000000000
17777777777777777777777777777777777177760000000017777777777777777777777716777776000000000000000076717776767177760000000000000000
11111111111111111111111111111111111177760000000011111111111111111111111116777776000000000000000076717776767177760000000000000000
76777776767777767677777676777776767777760000000076777767767777677677776776777776000000000000000076717776767177760000000000000000
66666666666666666666666666666666666666660000000066666666666666666666666666666666000000000000000066616666666166660000000000000000
77776777777767777777677777776777777767770000000077776777777767777777677777777677000000000000000077716776777167760000000000000000
77776777777767777777677777776777777767770000000077776777777767777777677777777677000000000000000077d1177677d117760000000000000000
6666666666666666666666666666666666666666000000006666666666666666666666666666666600000000000000006d1111666d1111660000000000000000
111111111111111111111111111111111111111111111111111111111111111100000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
177777777777777777777777777777777777777777777777777777777777777100000000fef555555efffffefefffffefefffffe000000000000000000000000
171117117711177711171117111717177771117111717177177717717777177100000000fe55777755fffffefefffffefefffffe000000000000000000000000
171717171717177771771777177717177771777177717171717171717777717100000000fe57777775555555555555fefefffffe000000000000000000000000
171117171711177771771177177711177771117177711171717171717711111100000000ee57755577577757755775eeeeeeeeee000000000000000000000000
171717171717177771771777177717177777717177717171717171717777717100000000ff5775f577577757755775ffffffefff000000000000000000000000
171717117717177771771117111717177771117111717177177717711177177100000000ff57755577575557755775ffffffefff000000000000000000000000
111111111111111111111111111111111111111111111111111111111111111100000000ee57777777577557755775eeeeeeeeee000000000000000000000000
eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeaaaaeeeeeee000000000000000000000000ee57777775575557755775eeeeeeeeee000000000000000000000000
fefffffefefffffe00000000fefffffefefaa8888aaffffe000000000000000000000000fe57775555577757775775fefefffffe000000000000000000000000
fefffffefefffffe00000000fefffffefea88800088afffe000000000000000000000000fe57775efe577757775775fefefffffe000000000000000000000000
fefff55555fffffe00000000fefffffefa8880008088affe000000000000000000000000fe55775efe575555555575fefefffffe000000000000000000000000
eeee5500055eeeee00000000eeeeeeeea888000008088aee000000000000000000000000eeee77eeeeee5555555eeeeeeeeeeeee000000000000000000000000
fff550000055efff00000000fffffeffa880000800008aff000000000000000000000000ffffe7fffff557777755555555555555000000000000000000000000
fff500000005efff00000000fffffefa80000800880088af000000000000000000000000ffffefffff5577777757775755757775000000000000000000000000
eee500000005eeee00000000eeeeeeea00000880088888ae000000000000000000000000eeeeeeeeee5777755557775775757775000000000000000000000000
eee500000005eeee00000000eeeeeeea00008008888888ae000000000000000000000000eeeeeeeeee577755ee57775777757555000000000000000000000000
fef550000055fffe00000000feffff000000000000000000000000000000000000000000fefffffefe577755fe57575777757775000000000000000000000000
feff51c1c15ffffe00000000feffff077777777770777770000000000000000000000000fefffffefe5777755557575757755575000000000000000000000000
fefff1ccc1fffffe00000000feffff000000000000000000000000000000000000000000fefffffefe5777777757775755757775000000000000000000000000
eeeee1ccc1eeeeee00000000eeeeeeeeea8888888888aeee000000000000000000000000eeeeeeeeeee557777757575755757775000000000000000000000000
ffffc1c1c1cfefff00000000fffffeffffa00000000aefff000000000000000000000000ffffefffffff55757755575555755755000000000000000000000000
fffffc0c0cffefff00000000fffffefffffaa0000aafefff000000000000000000000000ffffefffffffef7ff7ffefffff77efff000000000000000000000000
eeeeeec0ceeeeeee00000000eeeeeeeeeeeeeaaaaeeeeeee000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeee7eeee000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000eeee55eeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000fef555fe5555fffe555fff5ef55ffffe000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000fe5555fef5f5fffe5effff5efe5ffffe000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000f55f55fef555555e5effff555e5ffffe000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000eeee55eee5ee5e5e5555ee5e5e5eeeee000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000ffff55fff5ff555f5ff5ef555f55efff000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000fff5555fffffefff5555efffffffefff000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
66666666000000000000000066666666eeeeeeee5555555500000000000000006666666600000000000000000000000000000000000000000000000000000000
76777776000000000000000076777776fefffffe5666666500000000000000007677777600000000000000000000000000000000000000000000000000000000
76777776000000000000000076777776fefffffe5dddddd500000000000000007677777600000000000000000000000000000000000000000000000000000000
76777776000000000000000076777776fefffffe5111111500000000000000007677777600000000000000000000000000000000000000000000000000000000
66666666000000000000000066666666eeeeeeee5777777500000000000000006666666600000000000000000000000000000000000000000000000000000000
77776777000000000000000077776777ffffefff5666666500000000000000007777677700000000000000000000000000000000000000000000000000000000
77776777000000000000000077776777ffffefff5dddddd500000000000000007777677700000000000000000000000000000000000000000000000000000000
66666666000000000000000066666666eeeeeeee5111111500000000000000006666666600000000000000000000000000000000000000000000000000000000
57777775000000000000000000000000000000000000000000000000000000005555555500000000000000000000000000000000000000000000000000000000
56666665000000000000000000000000000000000000000000000000000000005666666500000000000000000000000000000000000000000000000000000000
5dddddd5000000000000000000000000000000000000000000000000000000005dddddd500000000000000000000000000000000000000000000000000000000
51111115000000000000000000000000000000000000000000000000000000005111111500000000000000000000000000000000000000000000000000000000
57777775000000000000000000000000000000000000000000000000000000005777777500000000000000000000000000000000000000000000000000000000
56666665000000000000000000000000000000000000000000000000000000005666666500000000000000000000000000000000000000000000000000000000
5dddddd5000000000000000000000000000000000000000000000000000000005dddddd500000000000000000000000000000000000000000000000000000000
51111115000000000000000000000000000000000000000000000000000000005111111500000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111100000000eeeee000000eeeee000000000000000000000000111111111111111111111111000000000000000000000000
1777777777777777777777777777777100000000ffff00333300ffff000000000000000000000000100000000000000000000001000000000000000000000000
1777777777777777777777777777777100000000fff0033333300fff000000000000000000000000100000000000000000000001000000000000000000000000
1777777777777755577777777777777100000000ff003333333300ff000000000000000000000000100000004444444440000001000000000000000000000000
17777777777775fff57777777777777100000000ee030aaaaaa030ee000000000000000000000000100000044444444444000001000000000000000000000000
1777777777775f667f5444444444477100000000ff00aaaaaaaa00ff000000000000000000000000100000044444444444000001000000000000000000000000
1777777777775f67074999aaaaaaa47100000000ff0aa0aaaa0aa0ff00000000000000000000000010000004fdddddddf4000001000000000000000000000000
1777777777775f66749aaaaaaaaaa47100000000ee0a0aaaa000a0ee00000000000000000000000010000004fffffffff4000001000000000000000000000000
17777777777775fd49aaa9999999477100000000ee00aaaa00f0a0ee00000000000000000000000010000004fddfffddf4000001000000000000000000000000
17777777777775fd49aaaaa99944777100000000f000aa000ff0a00f00000000000000000000000010000004fffdfdfff4000001000000000000000000000000
17777777777775ff49aaa9994477777100000000f0a00000f0000a0f0000000000000000000000001000000f000000000f000001000000000000000000000000
17777777777775ff499999447777777100000000f0a0700ff0070a0f0000000000000000000000001000000f0080d0000f000001000000000000000000000000
17777777775555fff49944777777777100000000e000f07ff70f000e0000000000000000000000001000000ff000d000ff000001000000000000000000000000
1777777755dddd5ffd4477777777777100000000fff00ffffff00fff00000000000000000000000010000000fffdddfff0000001000000000000000000000000
17777775dd666665ffd557777777777100000000ff000000000000ff00000000000000000000000010000005ffffdffff5000001000000000000000000000000
1777775766667666ddd657777777777100000000e00303333330300e00000000000000000000000010000550fffffffff0550001000000000000000000000000
17777775d676d666666657777777777100000000003303333330330000000000000000000000000015555000fffdddfff0005551000000000000000000000000
177777756ddd66666666577777777771000000000ff0033333300ff0000000000000000000000000100000000fdfffdf00000001000000000000000000000000
177777775dddddddddd57777777777710000000000f0300aa0030f00000000000000000000000000100550000dfffffd00005501000000000000000000000000
1777d7d77555555555577d7d7777777100000000f000330aa033000f000000000000000000000000100005000ddddddd00050001000000000000000000000000
1777777777777777777777777777777100000000ee000033330000ee0000000000000000000000001000050000fffff000050001000000000000000000000000
1777777777777777777777777777777100000000ff044400004440ff00000000000000000000000010000500000dfd0000050001000000000000000000000000
1777777777777777777777777777777100000000ff04400ff00440ff000000000000000000000000100005000000000000050001000000000000000000000000
1111111111111111111111111111111100000000eee00ffffff00eee000000000000000000000000111111111111111111111111000000000000000000000000
__gff__
0000000100000000000000010000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000101010000020000000000010114000000000000000400000000000000000000000000000000000000000000000000000000000000000001010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0505050505050505050505050505050505050505050505050505050505050505870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
052021222324050505050505050505050505050505050505050505052627281d870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1c3031323334050505050505050505050505050505050505050505053637382d870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c0505050505050505404142434445464705050505050505050505050505053d878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3c2a2b0505808305050505050505050505050505050505050505058503030303870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
030303030310050505050505050505051505c0c1c2c305050505050604040404878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040406050505050505050588830505d0d1d2d305051c05050604040404870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040406050505850303030310151c05e0e1e2e305052c05050604040404870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040406050505060404040406052c050505050505053c2a2b9084040404870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040406050505060404040406053c058883050585030303030304040404870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404060505059084040404030303031005050506040404040404040404878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040403030303030404494a4b0404040605050590840404040404040404878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040404040404040404595a5b5c04040303030303040404040404040404878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040404040404040404046a6b6c04040404040404040404040404040404878700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
505104045051040404040404797a7b7c04040404040450510404040450510404870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6061040460610404040404040404040404040404040460610404040460610404870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787878787878787878787878787878787878787878787878787878787878787878787000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8787870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002a0502c05030050320503405036050360503505033050300502c0502905024050200501d0501805016050110500f0500c050090500505003050020500105000050000500000000000000000000000000
0001000014050190501b0501e05022050250502605027050270502705027050260502505022050200501c050190501505013050110500f0500c05009050070500405004050020500105001050000500000000000
00010000180501a0501d0501e0501d0501d0501c0501b0501a0501805014050110500f0500b050080500605003050020500005000050000500000000000000000000000000000000000000000000000000000000
000100000f0501405015050150501405013050110500e0500c0500a05008050060500305002050000500005001050010500000000000000000000000000000000000000000000000000000000000000000000000
000100002625023250222501d25019250172501525013250102500d250082500625001250002500005000150100000d0000a00007000040000200000000011000010000100001001610016100171001b10022100
