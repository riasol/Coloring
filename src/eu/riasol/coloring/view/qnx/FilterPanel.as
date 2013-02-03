package eu.riasol.coloring.view.qnx {
	import eu.riasol.coloring.application.ColoringEvent;
	import eu.riasol.coloring.application.ColoringEventDispatcher;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import qnx.ui.buttons.Button;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.display.Image;
	import qnx.ui.events.SliderEvent;
	import qnx.ui.slider.Slider;
	import qnx.ui.text.Label;

	public class FilterPanel extends Container {
		private var applyBtn:LabelButton;
		private var slider:Slider;
		[Embed(source="/filter.gif")]
		public var Icon:Class;
		public function FilterPanel(s:Number=100, su:String="percent") {
			super(s, su);
			flow=ContainerFlow.VERTICAL
			padding=10
			var img:Image=new Image()
			img.setImage(new Icon() as Bitmap)
			addChild(img)
			slider=new Slider()
			slider.minimum=0.1
			slider.maximum=3
				slider.addEventListener(SliderEvent.END,onSliderEnd)
			addChild(slider)
			applyBtn=new LabelButton()
			applyBtn.width=100
			applyBtn.label='apply'
			applyBtn.toggle=true
			applyBtn.addEventListener(MouseEvent.CLICK, applyFilter)
			addChild(applyBtn)
		}
		private function onSliderEnd(e:SliderEvent):void{
			applyFilter()
		}
		private function applyFilter(e:MouseEvent=null):void {
			var ev:ColoringEvent=new ColoringEvent(applyBtn.selected ? ColoringEvent.EVENT_APPLY_FILTER : ColoringEvent.EVENT_REMOVE_FILTER)
			ev.data={amount:slider.value}
			ColoringEventDispatcher.instance.dispatchEvent(ev)
		}
	}
}