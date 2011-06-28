﻿package  
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class ScreenHandler extends Sprite
	{
		private var splashScreen:SplashScreen;
		private var mainMenu:MainMenu;
		private var tutorial:Tutorial;
		private var level1:Level1;
		
		private var newScreenName:String = "";
		
		private var screenLayer:Sprite = new Sprite();
		private var transitionLayer:Sprite = new Sprite();
		private var transition:Transition;
		private var transTimer:Number = 0;
		private var makeTransition:Boolean;
		
		public function ScreenHandler() 
		{
			this.addChild(screenLayer);
			this.addChild(transitionLayer);
			splashScreen = new SplashScreen();
			screenLayer.addChild(splashScreen);
		}
		
		public function switchTo(screenName:String, trans:Boolean = true):void
		{
			newScreenName = screenName;
			makeTransition = trans;
			this.addEventListener(Event.ENTER_FRAME, switchScreens);
		}
		
		private function switchScreens(e:Event):void
		{
			if(makeTransition){
				transTimer++;
				if(transTimer == 1 && transitionLayer.numChildren < 1){
					transition = new Transition();
					transitionLayer.addChild(transition);
				}
				if(transTimer == transition.exitFrames){
					removeOldScreen();
					makeNewScreen();
					transTimer = 0;
					this.removeEventListener(Event.ENTER_FRAME, switchScreens);
				}
			} else {
				removeOldScreen();
				makeNewScreen();
				this.removeEventListener(Event.ENTER_FRAME, switchScreens);
			}
		}
		
		private function removeOldScreen():void
		{
			var oldScreen:MovieClip;
			oldScreen = screenLayer.getChildAt(0) as MovieClip;
			screenLayer.removeChild(oldScreen);
		}
		
		private function makeNewScreen():void
		{
			switch(newScreenName){
				case "SplashScreen":
					splashScreen = new SplashScreen();
					screenLayer.addChild(splashScreen);
				break;
				case "MainMenu":
					mainMenu = new MainMenu();
					screenLayer.addChild(mainMenu);
				break;
				case "Tutorial":
					tutorial = new Tutorial();
					screenLayer.addChild(tutorial);
				break;
				case "Level1":
					level1 = new Level1();
					screenLayer.addChild(level1);
				break;
				default:
					mainMenu = new MainMenu();
					screenLayer.addChild(mainMenu);
				break;
			}
			newScreenName = "";
		}
		

		/*private function makeNewScreen():void 
		  {
			trace(newScreenName);
		   var firstLetter:String = newScreenName.substring(0,1);
		   var restLetters:String = newScreenName.substring(1,newScreenName.length);
		   var screenNameLowerCase:String = firstLetter.toLowerCase() + restLetters;
			trace(screenNameLowerCase);

			// It doesn't like how I use the "new" keyword infront of this[newScreenName]()
			// this[newScreenName]() can be used to call a function, but
			// new this[newScreenName](); won't initialize
			// Look into it later.
			
		   this[screenNameLowerCase] = new this[newScreenName]();
		   screenLayer.addChild(this[screenNameLowerCase]);

		   newScreenName = "";
		}*/

		
	}
}