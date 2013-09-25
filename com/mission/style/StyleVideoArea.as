package com.mission.style 
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lu
	 */
	public class StyleVideoArea extends StyleAreaBase 
	{
		private var _name:String;
		
		public function StyleVideoArea() 
		{
			
		}
		
		override public function parseXML(xml:XML):void {
			super.parseXML(xml);
			
			if (xml.property.@name) {
				_name = xml.property.@name;
			}
			
			updateView();
		}
		
		
		private function updateView():void {
			var _rc:Rectangle = new Rectangle(_x, _y, _width, _height);
			
			var _g:Graphics = this.graphics;
			_g.lineStyle(0, 0x000000);
			_g.beginFill(0xffff00, 0.4);
			_g.drawRect(_rc.x, _rc.y, _rc.width, _rc.height);
			_g.endFill();
			
			
			
		}
	}

}