# bluedog-v2

Initial save state must be in slot 1 and copied in slot 3 and 4. The save state must be done such that pressing A starts the race. I recommend using Rice as the video plugin (N64->Plugins->Active Video Plugin) as I got better performances under it. Be sure that bluedog_stats.txt is in the same folder as goldboi.lua. It is used to track stats about the simulations, which are important for the duct tape fix I implemented. In short, Bizhawk doesn't like saving and loading save states over and over, and it starts to glitch after around 1k iterations, so I implemented a quick fix for this.

# Letters meaning

n: number of simulations

g: number of time glitch happened

s: number of second place

a: number of 3rd, 4th or 5th place

b: number of >5th place

k: number of time blue dog won due to glitch (may be true win as well)

w: number of true win

p: number of time blue dog finished second and the glitch happened (true win stolen)

d: number of time the glitch happened to two dogs or more in a single race

# Blue First Gold Last (actually tie for first place)

https://www.youtube.com/watch?v=xEQQu6QvHJA

To reproduce the win, download the save state and lua script from the folder \bluefirstgoldlast. Put the save state file in \BizHawk-2.9.1-win-x64\N64\State and the lua script in \BizHawk-2.9.1-win-x64\Lua. Then boot Bizhawk, load the majora's mask rom, go to Tools->Lua Console. In the Lua Console, go to Script->Open Script... then choose the _playwin6.lua. The SHA-256 hash of the rom is efb1365b3ae362604514c0f9a1a2d11f5dc8688ba5be660a37debf5e3be43f2b.
