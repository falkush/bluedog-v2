input = {};
doubleglitch=false;
stop=0;


i=0;
glitchcount=0;
second=0;
almost=0;
bad=0;



savestate.loadslot(3);
savestate.saveslot(1);

while true do
ff=true;
for k=0,1000 do
	if ff then
		savestate.loadslot(1);
		emu.frameadvance();
		emu.frameadvance();
		emu.frameadvance();
		savestate.saveslot(2);
	else
		savestate.loadslot(2);
		emu.frameadvance();
		emu.frameadvance();
		emu.frameadvance();
		savestate.saveslot(1);
	end
	ff=not(ff);

	input['P1 A'] = true;
	joypad.set(input);
	emu.frameadvance();
	input['P1 A'] = false;
	joypad.set(input);
	
	for j=0,1600 do
		emu.frameadvance();
		gui.text(0,0,"nb: " .. i .. " | glitch: " .. glitchcount .. " | 2nd: " .. second .. " | almst: " .. almost .. " | bad: " .. bad);
	end

	glitch=false;
	test = mainmemory.readbyte(4353633);
	if test ~= 0 then
		glitch=true;
		glitchcount=glitchcount+1;
		if test > 1 then
			doubleglitch=true;
		end
	end

	inrace=true;
	while inrace do
		emu.frameadvance();
		test = mainmemory.read_s16_be(4182828);
		if test ~= 0 then
			inrace=false;
		end
		gui.text(0,0,"nb: " .. i .. " | glitch: " .. glitchcount .. " | 2nd: " .. second .. " | almst: " .. almost .. " | bad: " .. bad);
	end
	
	if test==13611 then
		second=second+1;
	elseif test==13612 then
		almost=almost+1;
	elseif test==13613 then
		bad=bad+1;
	end
	
	
	if test==13610 and glitch then
		stop=1; --first place glitched (maybe also true)
	elseif test==13610 then
		stop=2; --first place true
	elseif test==13611 and glitch then
		stop=3; --second place glitch happened
	elseif doubleglitch then
		stop=4; --double glitch
	end

	if stop ~= 0 then
		while true do
			if ff then
				gui.text(0,0,"nb: " ..i .. "     glitch: " .. glitchcount .. "     STOP: " .. stop .. "   save: 2");
			else
				gui.text(0,0,"nb: " ..i .. "     glitch: " .. glitchcount .. "     STOP: " .. stop .. "   save: 1");
			end
			emu.frameadvance();
		end
	end

	i=i+1;
end

savestate.loadslot(3);
for k=0,1000 do
	emu.frameadvance();
	gui.text(0,0,"////duct tape quick fix///");
	emu.frameadvance();
	gui.text(0,0,"////duct tape quick fix///");
	emu.frameadvance();
	gui.text(0,0,"////duct tape quick fix///");
end
savestate.saveslot(3);
savestate.saveslot(1);

end
