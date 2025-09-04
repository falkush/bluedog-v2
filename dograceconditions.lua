--Save state (slot 0) must be done in front of the door to enter the dog track area, facing the door so that pressing A opens the door. Will bruteforce favorable conditions for blue dog to win. Creates a save state in slot 8 once it finds something.
--Once found, it is possible that the conditions are incorrect. You must start the race and use majoradograce.wch and verify the race values.

--blue dog must have value <= 0x353C
--gray and beige dogs must have values <=0x3541
--white and brown dogs must have values >=0x353D
--gold dog must have value >=0x3542

input = {};

while true do
	
	savestate.loadslot(10);
	emu.frameadvance();
	emu.frameadvance();
	savestate.saveslot(10);

	emu.frameadvance();

	input['P1 A'] = true;
	joypad.set(input);
	emu.frameadvance();
	input['P1 A'] = false;
	joypad.set(input);
	emu.frameadvance();
	
	for j=0,250 do
		emu.frameadvance();
	end

	flag=0;
	test = mainmemory.read_s16_be(4352956); --beige
	if test > 13632 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352992); --beige
	if test > 13632 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4353022); --beige
	if test > 13632 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352968); --blue
	if test > 13627 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352980); --brown
	if test < 13628 and test ~= 13624 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4353034); --brown
	if test < 13628 and test ~= 13624 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4353010); --gold
	if test < 13633 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352974); --gray
	if test > 13632 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352986); --gray
	if test > 13632 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4353016); --gray
	if test > 13632 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352962); --white
	if test < 13628 and test ~= 13624 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4352998); --white
	if test < 13628 and test ~= 13624 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4353004); --white
	if test < 13628 and test ~= 13624 then
		flag=1;
	end

	test = mainmemory.read_s16_be(4353028); --white
	if test < 13628 and test ~= 13624 then
		flag=1;
	end

	if flag == 0 then
		savestate.saveslot(8);
		while true do
			gui.text(0,0,"FOUND!!");
			emu.frameadvance();
		end
	end
end