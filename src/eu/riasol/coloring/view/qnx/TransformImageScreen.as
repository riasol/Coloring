package eu.riasol.coloring.view.qnx {

	import caurina.transitions.Tweener;

	import com.nocircleno.graffiti.GraffitiCanvas;
	import com.nocircleno.graffiti.tools.BrushTool;
	import com.nocircleno.graffiti.tools.BrushType;

	import eu.riasol.coloring.application.ColoringEvent;
	import eu.riasol.coloring.application.ColoringEventDispatcher;
	import eu.riasol.coloring.application.SketchingFilter;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	import flashprolib.util.DisplayUtils;

	import org.corlan.asviews.BaseView;

	import qnx.ui.buttons.BackButton;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerAlign;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.display.Image;
	import qnx.ui.progress.PercentageBar;
	import qnx.ui.text.TextInput;

	public class TransformImageScreen extends BaseView {
		public function TransformImageScreen(s:Number=100, su:String="percent") {
			super(s, su);
		}
		private var image:Image;
		private var progr:PercentageBar;
		private var ldCont:Container
		private var ldSprite:Sprite;
		private var drawCanvasContainer:Sprite;

		override protected function createUI():void {
			var mainCont:Container=new Container()
			addChild(mainCont)
			mainCont.width=100
			mainCont.sizeUnit=SizeUnit.PERCENT
			mainCont.margins=Vector.<Number>([8, 8, 8, 8])
			/*CONFIG::debug {
				mainCont.debugColor=0x0000ff
			}*/
			var toolCont:Container=new Container()
			mainCont.addChild(toolCont)
			toolCont.sizeUnit=SizeUnit.PIXELS
			toolCont.containment=Containment.DOCK_LEFT
			/*CONFIG::debug {
				toolCont.debugColor=0x00ff00
			}*/
			ldCont=new Container()
			mainCont.addChild(ldCont);
			ldCont.flow=ContainerFlow.VERTICAL
			ldCont.align=ContainerAlign.NEAR
			ldCont.setSize(85, 100)
			ldCont.sizeUnit=SizeUnit.PERCENT
			ldCont.containment=Containment.DOCK_LEFT
			/*CONFIG::debug {
				ldCont.debugColor=0xff0000
			}*/
			ldSprite=new Sprite()
			ldCont.addChild(ldSprite);
			image=new Image()
			ldSprite.addChild(image);
			drawCanvasContainer=new Sprite()
			ldSprite.addChild(drawCanvasContainer);
			progr=new PercentageBar();
			ldCont.addChild(progr);

			var fp:FilterPanel=new FilterPanel()
			toolCont.addChild(fp)
			toolCont.addChild(new Brush())
			var saveComp:SaveComponent=new SaveComponent()
			saveComp.saveDrawable=ldSprite
			toolCont.addChild(saveComp)
			var b:BackButton=new BackButton()
			toolCont.addChild(b)
			b.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				navigator.popView();
			})
			ColoringEventDispatcher.instance.addEventListener(ColoringEvent.EVENT_APPLY_FILTER, onColoringEvent)
			ColoringEventDispatcher.instance.addEventListener(ColoringEvent.EVENT_REMOVE_FILTER, onColoringEvent)
			ColoringEventDispatcher.instance.addEventListener(ColoringEvent.EVENT_BRUSH_SIZE_SELECT, onColoringEvent)
			ColoringEventDispatcher.instance.addEventListener(ColoringEvent.EVENT_COLOR_SELECT, onColoringEvent)
		}
		private var selectedColor:uint=0xff000000;
		private var selectedSize:Number=10;
		private var drawCanvas:GraffitiCanvas
		private function onColoringEvent(e:ColoringEvent):void {
			var f:SketchingFilter
			switch(e.type) {
				case ColoringEvent.EVENT_APPLY_FILTER:
					if(image.width > 0) {
						f=new SketchingFilter(image)
						f.applyFilter(e.data.amount, 1)
						drawCanvas=new GraffitiCanvas(image.width, image.height)
						if(drawCanvasContainer.numChildren == 1) {
							drawCanvasContainer.removeChildAt(0)
						}
						drawCanvasContainer.addChild(drawCanvas)
						onBrushParamChange()
					}

					break;
				case ColoringEvent.EVENT_REMOVE_FILTER:
					f=new SketchingFilter(image)
					f.removeFilter()
					break;
				case ColoringEvent.EVENT_COLOR_SELECT:
					selectedColor=e.data.color
					onBrushParamChange()
					break;
				case ColoringEvent.EVENT_BRUSH_SIZE_SELECT:
					selectedSize=e.data.size
					onBrushParamChange()
					break;
			}
		}
		private function onBrushParamChange():void {
			if(drawCanvas) {
				drawCanvas.activeTool=new BrushTool(selectedSize, selectedColor, 1, 3, BrushType.ROUND)
			}
		}
		override protected function applyData():void {
			if(data.hasOwnProperty('image')) {
				image.setImage(data.image);
				image.addEventListener(ProgressEvent.PROGRESS, onProgress)
				image.addEventListener(Event.COMPLETE, onComplete)
				image.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {})
				progr.alpha=0
				progr.visible=true
			}
		}
		private function onProgress(e:ProgressEvent):void {
			progr.alpha=Math.min(1, e.bytesLoaded / e.bytesTotal * 8)
			progr.progress=e.bytesLoaded / e.bytesTotal * 100;
		}
		private function onComplete(e:Event):void {
			Tweener.addTween(progr, {_autoAlpha:0})
			var sc:Number=DisplayUtils.noOverScale([image.width, image.height], [ldCont.width, ldCont.height])
			image.scaleX=image.scaleY=sc
			DisplayUtils.centerAbstract([image.width, image.height], [ldCont.width, ldCont.height], ldSprite)
			image.removeEventListener(ProgressEvent.PROGRESS, onProgress)
			image.removeEventListener(Event.COMPLETE, onComplete)
		}
	}
}