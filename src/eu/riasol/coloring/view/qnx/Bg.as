package eu.riasol.coloring.view.qnx
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Bg extends Sprite
	{
		[Embed(source="/tlo.gif")]
		public var I:Class;
		public function Bg()
		{
			super();
			var bmpInstance:Bitmap=new I() as Bitmap;
			addChild(bmpInstance)
		}
	}
}