input = {};

	savestate.loadslot(6);
	emu.frameadvance();
	emu.frameadvance();
	emu.frameadvance();

	input['P1 A'] = true;
	joypad.set(input);
	emu.frameadvance();
	input['P1 A'] = false;
	joypad.set(input);
	
	while true do
		emu.frameadvance();
	end