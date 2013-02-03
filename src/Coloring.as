package {
	import caurina.transitions.Tweener;
	
	import eu.riasol.coloring.application.TweenConfig;
	import eu.riasol.coloring.view.qnx.Bg;
	import eu.riasol.coloring.view.qnx.HomeScreen;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.corlan.asviews.ViewNavigator;

	[SWF(height="600", width="1024", frameRate="30", backgroundColor="#FFFFFF")]
	public class Coloring extends Sprite {
		private var navigator:ViewNavigator;
		public function Coloring() {
			super();
			TweenConfig.initTweener()
				addChild(new Bg())
			navigator=new ViewNavigator(this, true)
			navigator.pushView(HomeScreen)
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, navigator.prepareForClosing, false, 0, true);
		}
	}
}