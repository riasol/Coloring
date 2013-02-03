package eu.riasol.coloring.view.qnx {

	import eu.riasol.coloring.application.ColoringEvent;
	import eu.riasol.coloring.application.ColoringEventDispatcher;
	
	import flash.events.MouseEvent;
	
	import org.corlan.asviews.BaseView;
	
	import qnx.ui.buttons.BackButton;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerAlign;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;

	public class SelectImageScreen extends BaseView {
		public function SelectImageScreen(s:Number=100, su:String="percent") {
			super(s, su);
			ColoringEventDispatcher.instance.addEventListener(ColoringEvent.EVENT_IMAGE_SELECT, onImageSelect)
		}
		override protected function createUI():void {
			flow=ContainerFlow.VERTICAL;
			
			addChild(new GoogleSearchComponent());
			var l:Label=new Label();
			l.text='or enter URL';
			l.width=300
			addChild(l);
			
			var c1:Container=new Container()
			c1.padding=6
			c1.size=10
			c1.sizeUnit=SizeUnit.PERCENT	
			addChild(c1)
			c1.flow=ContainerFlow.HORIZONTAL;
			var i:TextInput=new TextInput();
			c1.addChild(i);
			var b:LabelButton=new LabelButton();
			b.label='load';
			c1.addChild(b);
			b.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				if(i.text.length<1){
					return
				}
				navigator.pushView(TransformImageScreen, {image:i.text})
			})
			var c2:Container=new Container()
				c2.size=10
				c2.sizeUnit=SizeUnit.PERCENT	
			addChild(c2)
			b=new BackButton()
			c2.addChild(b)
			b.containment=Containment.DOCK_LEFT
			b.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				navigator.popView()
			})
		}

		override protected function applyData():void {
		}
		private function onImageSelect(e:ColoringEvent):void {
			navigator.pushView(TransformImageScreen, {image:e.data.image})
		}
	}
}