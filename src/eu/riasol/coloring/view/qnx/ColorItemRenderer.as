package eu.riasol.coloring.view.qnx {
	import flash.display.Sprite;

	import qnx.ui.listClasses.DropDownCellRenderer;

	public class ColorItemRenderer extends DropDownCellRenderer {
		private var drawTarget:Sprite;
		public function ColorItemRenderer() {
			super();
			drawTarget=new Sprite()
		}
		override protected function onAdded():void {
			super.onAdded()
			addChild(drawTarget)
			label.visible=false
		}
		override protected function onRemoved():void {
			super.onRemoved()
			removeChild(drawTarget)
		}
		override protected function drawLabel():void {
			super.drawLabel()
			if(data == null) {
				return;
			}
			with(drawTarget.graphics) {
				beginFill(data.color)
				drawRect(3, 5, width - 7, height - 10)
				endFill()
			}
		}
	}
}