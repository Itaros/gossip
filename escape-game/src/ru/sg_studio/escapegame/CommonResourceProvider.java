package ru.sg_studio.escapegame;

public class CommonResourceProvider {

	private GossipVM VM;

	public void load(GameScreen bindedScreen) {
		VM = new GossipVM();
		VM.load();
		VM.provideInitialScreen(bindedScreen);
	}
	
	public void dispose(){
		
	}
	
}