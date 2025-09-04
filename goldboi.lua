input = {};
doubleglitch=false;
stop=0;

file = io.open("bluedog_stats.txt", "r");

i=file:read("*number");
glitchcount=file:read("*number");
second=file:read("*number");
almost=file:read("*number");
bad=file:read("*number");
s1=file:read("*number");
s2=file:read("*number");
s3=file:read("*number");
s4=file:read("*number");
savenb=file:read("*number");

file:close();

while true do

if i % 1000000 == 0 and i > 0 then
	savestate.loadslot(4);
	for k=0,999999 do
		emu.frameadvance();
		gui.text(0,0,"////BIG duct tape quick fix///");
		emu.frameadvance();
		gui.text(0,0,"////BIG duct tape quick fix///");
		emu.frameadvance();
		gui.text(0,0,"////BIG duct tape quick fix///");
	end
	savestate.saveslot(3);
	savestate.saveslot(4);
	savestate.saveslot(1);
elseif i % 1000 == 0 and i > 0 then
	savestate.loadslot(3);
	for k=0,999 do
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

if i % 2 == 0 then
	ff=true;
else
	ff=false;
end

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

	file = io.open("bluedog_stats.txt", "w");
	file:write(i);
	file:write("\n");
	file:write(glitchcount);
	file:write("\n");
	file:write(second);
	file:write("\n");
	file:write(almost);
	file:write("\n");
	file:write(bad);
	file:write("\n");
	file:write(s1);
	file:write("\n");
	file:write(s2);
	file:write("\n");
	file:write(s3);
	file:write("\n");
	file:write(s4);
	file:write("\n");
	file:write(savenb);
	file:close();

	input['P1 A'] = true;
	joypad.set(input);
	emu.frameadvance();
	input['P1 A'] = false;
	joypad.set(input);
	
	for j=0,1800 do
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
	
	stop=0;
	if test==13610 and glitch then
		stop=1; --first place glitched (maybe also true)
		s1=s1+1;
	elseif test==13610 then
		stop=2; --first place true
		s2=s2+1;
	elseif test==13611 and glitch then
		stop=3; --second place glitch happened
		s3=s3+1;
	end

	if doubleglitch then
		stop=4; --double glitch
		s4=s4+1;
		if ff then
			savestate.loadslot(1);
			savestate.saveslot(10);
		else
			savestate.loadslot(2);
			savestate.saveslot(10);
		end
	end

	if stop ~= 0 then
		if ff then
			savestate.loadslot(1);
			savestate.saveslot(savenb);
		else
			savestate.loadslot(2);
			savestate.saveslot(savenb);
		end

		savenb=savenb+1;
		if savenb==10 then
			savenb=5;
		end
	end

	if stop==3 then
		while true do
			gui.text(0,0,"FOUND!!!");
			emu.frameadvance();
		end
	end
	i=i+1;
end