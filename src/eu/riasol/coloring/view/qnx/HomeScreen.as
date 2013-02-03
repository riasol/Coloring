package eu.riasol.coloring.view.qnx {
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	import org.corlan.asviews.BaseView;

	import qnx.ui.buttons.Button;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.text.Label;

	public class HomeScreen extends BaseView {
		public function HomeScreen(s:Number=100, su:String="percent") {
			super(s, su);
		}
		override protected function createUI():void {
			padding=8
			flow=ContainerFlow.VERTICAL;
			var l:Label=new Label()
			l.width=400;
			l.height=80
			l.text="Colouring Image Application by AMU"
				l.label_txt.textColor=0xffffff
			addChild(l)
			l=new Label()
			//l.autoSize=TextFieldAutoSize.LEFT
			l.multiline=true
			l.label_txt.textColor=0xffffff
			l.htmlText="1. Search for image or enter url"
			l.htmlText+="<br/><br/>2. Transform image to outline"
			l.htmlText+="<br/><br/>3. Paint it"
			l.width=400;
			l.height=200;
			addChild(l)
			var b:LabelButton=new LabelButton()
			b.label='search for image'
			addChild(b)
			b.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				navigator.pushView(SelectImageScreen)
			})
		}

		override protected function applyData():void {
		}
	}
}