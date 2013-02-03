package eu.riasol.coloring.view.qnx {
	import eu.riasol.coloring.application.ColoringEvent;
	import eu.riasol.coloring.application.ColoringEventDispatcher;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.data.DataProvider;
	import qnx.ui.display.Image;
	import qnx.ui.events.SliderEvent;
	import qnx.ui.listClasses.DropDown;
	import qnx.ui.slider.Slider;

	public class Brush extends Container {
		private var palette:Array
		private var list:DropDown
		private var slider:Slider;
		private var sizeCircle:Sprite
		private var selectedColor:uint
		private var selectedSize:Number
		[Embed(source="/pen.gif")]
		public var Icon:Class;
		public function Brush(s:Number=100, su:String="percent") {
			super(s, su);
			flow=ContainerFlow.VERTICAL
			padding=10
				var img:Image=new Image()
					img.setImage(new Icon() as Bitmap)
						addChild(img)
			palette='252 233 79,237 212 0,196 160 0,138 226 52,115 210 22,78 154 6,252 175 62,245 121 0,206 92 0,114 159 207,52 101 164,32 74 135,173 127 168,117 80 123,92 53 102,233 185 110,193 125 17,143 89 2,239 41 41,204 0 0,164 0 0,238 238 236,211 215 207,186 189 182,136 138 133,85 87 83,46 52 54'.split(',')
			palette.forEach(function(item:*, index:int, array:Array):void {
				var colors:Array=String(item).split(' ')
				array[index]={color:Number(colors[0]) << 16 | Number(colors[1]) << 8 | Number(colors[2]), label:''}
			})
			list=new DropDown()
			list.showListAbove=true
			list.setListSkin(ColorItemRenderer)
			list.dataProvider=new DataProvider(palette)
			list.selectedIndex=8
			list.addEventListener(Event.SELECT, onColorSelect)
			list.width=100
				//list.setButtonSkin(ColorButtonSkin)
			addChild(list)
			slider=new Slider()
			slider.minimum=3
			slider.maximum=20
			selectedSize=slider.value=8
			slider.addEventListener(SliderEvent.END, onSliderEnd)
			slider.addEventListener(SliderEvent.MOVE, onSliderMove)
			addChild(slider)
			sizeCircle=new Sprite()
			sizeCircle.width=sizeCircle.height=50
			var circleCont:Sprite=new Sprite()
			addChild(circleCont)	
			circleCont.addChild(sizeCircle)
			sizeCircle.y=20
			ColoringEventDispatcher.instance.addEventListener(ColoringEvent.EVENT_COLOR_SELECT, onColoringEvent)
			callLater(onSliderEnd)
			callLater(onColorSelect)
			//setChildIndex(list,numChildren-1)	
		}
		private function onColorSelect(e:Event=null):void {
			selectedColor=list.selectedItem.color
			var ev:ColoringEvent=new ColoringEvent(ColoringEvent.EVENT_COLOR_SELECT)
			ev.data={color:selectedColor}
			ColoringEventDispatcher.instance.dispatchEvent(ev)
		}
		private function onSliderEnd(e:SliderEvent=null):void {
			var ev:ColoringEvent=new ColoringEvent(ColoringEvent.EVENT_BRUSH_SIZE_SELECT)
			selectedSize=slider.value
			ev.data={size:selectedSize}
			ColoringEventDispatcher.instance.dispatchEvent(ev)
			onSliderMove()
		}
		private function onSliderMove(e:SliderEvent=null):void {
			sizeCircle.scaleX=sizeCircle.scaleY=slider.value
		}
		private function onColoringEvent(e:ColoringEvent):void {
			with(sizeCircle.graphics) {
				clear()
				beginFill(e.data.color)
				drawCircle(0, 0, 1)
			}
		}

	}
}