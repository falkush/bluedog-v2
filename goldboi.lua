input = {};
doubleglitch=false;
stop=0;
savenb=4;


i=118860;
glitchcount=60;
second=16;
almost=13462;
bad=105373;
s1=4;
s2=6;
s3=0;
s4=0;

while true do

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
		gui.text(0,0,"n:" .. i .. "|g:" .. glitchcount .. "|s:" .. second .. "|a:" .. almost .. "|b:" .. bad .. "|k:" .. s1 .. "|w:" .. s2 .. "|p:" .. s3 .. "|d:" .. s4);
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
		gui.text(0,0,"n:" .. i .. "|g:" .. glitchcount .. "|s:" .. second .. "|a:" .. almost .. "|b:" .. bad .. "|k:" .. s1 .. "|w:" .. s2 .. "|p:" .. s3 .. "|d:" .. s4);
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
		s1=s1+1;
	elseif test==13610 then
		stop=2; --first place true
		s2=s2+1;
	elseif test==13611 and glitch then
		stop=3; --second place glitch happened
		s3=s3+1;
	elseif doubleglitch then
		stop=4; --double glitch
		s4=s4+1;
	end

	if stop ~= 0 then
		if ff then
			savestate.loadslot(2);
			savestate.saveslot(savenb);
		else
			savestate.loadslot(1);
			savestate.saveslot(savenb);
		end

		savenb=savenb+1;
		if savenb==10 then
			savenb=4;
		end
		stop=0;
	end

	i=i+1;
end
end
