package eu.riasol.coloring.application
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;

	public class SketchingFilter
	{
		public var target:DisplayObject;
		public function SketchingFilter(target:DisplayObject)
		{
			this.target=target
		}
		/**
		 * divisorAmount from 0.1 to 3
		 * biasAmount - 0 to 255
		 */ 
		public function applyFilter(divisorAmount:Number,biasAmount:Number):void{
				var matrix:Array=[
					-1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1,
					-1, -1, 24, -1, -1,
					-1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1
				];
				var divisor:Number=0;
				for each(var index:Number in matrix) {
					divisor+=index;
				}
				var filter:ConvolutionFilter=new ConvolutionFilter();
				filter.matrixX=5;
				filter.matrixY=5;
				filter.matrix=matrix;
				filter.divisor=divisorAmount;
				filter.bias=biasAmount;
				
				matrix=[
					-1, 0, 0, 0, 255,
					0, -1, 0, 0, 255,
					0, 0, -1, 0, 255,
					0, 0, 0, 1, 0
				];
				var colorFilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);
				
				target.filters=[filter, colorFilter];
		}
		public function removeFilter():void{
			target.filters=[];
		}
	}
}